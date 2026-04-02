#!/bin/bash
set -euo pipefail

# =============================================================================
# MCP Stack Setup: CodeGraph + Cognee
# =============================================================================
#
# This script installs and configures two MCP servers for Claude Code:
#
#   1. CodeGraph — Local code indexing (Tree-sitter + SQLite)
#      Gives Claude: symbol search, caller/callee tracing, impact analysis
#
#   2. Cognee — Knowledge graph + vector memory (KuzuDB + LanceDB + SQLite)
#      Gives Claude: cross-session memory, codebase knowledge graphs,
#      semantic search over past decisions/lessons
#
# PREREQUISITES:
#   - Node.js 18+ (for CodeGraph)
#   - Python 3.10+ with uv (for Cognee)
#   - Anthropic API key (Cognee LLM for entity extraction)
#   - Ollama with nomic-embed-text (Cognee embeddings — Anthropic has no embeddings API)
#
# USAGE:
#   chmod +x ~/.claude/setup-mcp-stack.sh
#   ~/.claude/setup-mcp-stack.sh
#
# =============================================================================

CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
COGNEE_DIR="$CLAUDE_DIR/cognee-mcp"
LOG_FILE="$CLAUDE_DIR/setup-mcp-stack.log"

echo "=========================================="
echo "  MCP Stack Setup: CodeGraph + Cognee"
echo "=========================================="
echo ""
echo "Logging to: $LOG_FILE"
echo ""

# Redirect all output to log file AND terminal
exec > >(tee -a "$LOG_FILE") 2>&1

# ---------------------------------------------------------------------------
# STEP 0: Check prerequisites
# ---------------------------------------------------------------------------
echo "--- Step 0: Checking prerequisites ---"

check_cmd() {
  if ! command -v "$1" &>/dev/null; then
    echo "ERROR: $1 is not installed. $2"
    return 1
  fi
  echo "  ✓ $1 found: $(command -v "$1")"
}

check_cmd node "Install via: brew install node" || exit 1
check_cmd npm "Comes with Node.js" || exit 1
check_cmd python3 "Install via: brew install python@3.11" || exit 1

# Check uv (Python package manager — much faster than pip)
if ! command -v uv &>/dev/null; then
  echo "  ⚠ uv not found. Installing..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi
check_cmd uv "Should have been installed above"

# Check Ollama (needed for local embeddings — Anthropic has no embeddings API)
if ! command -v ollama &>/dev/null; then
  echo ""
  echo "  ⚠ Ollama not found."
  echo "  Cognee needs an embedding model. Anthropic doesn't offer embeddings,"
  echo "  so we use Ollama to run nomic-embed-text locally."
  echo ""
  read -p "  Install Ollama now? (y/n): " INSTALL_OLLAMA
  if [[ "$INSTALL_OLLAMA" =~ ^[Yy] ]]; then
    brew install ollama 2>&1 || {
      echo "  brew install failed. Install manually: https://ollama.com/download"
      exit 1
    }
  else
    echo "  Skipping Ollama install. You'll need to configure an alternative embedding provider."
    echo "  Options: OpenAI embeddings (needs OPENAI_API_KEY) or fastembed (CPU-only, local)"
  fi
fi

OLLAMA_AVAILABLE=false
if command -v ollama &>/dev/null; then
  echo "  ✓ Ollama found"
  OLLAMA_AVAILABLE=true

  # Ensure Ollama is running
  if ! pgrep -x "ollama" &>/dev/null && ! curl -s http://localhost:11434/api/tags &>/dev/null; then
    echo "  Starting Ollama service..."
    ollama serve &>/dev/null &
    sleep 2
  fi

  # Pull embedding model if not already present
  if ! ollama list 2>/dev/null | grep -q "nomic-embed-text"; then
    echo "  Pulling nomic-embed-text embedding model (~274MB)..."
    ollama pull nomic-embed-text 2>&1
  fi
  echo "  ✓ nomic-embed-text model available"

  # Register Ollama as a launch agent so it auto-starts on boot.
  # This ensures Cognee embeddings work in VS Code / IDE sessions
  # where the terminal setup script hasn't run first.
  if ! brew services list 2>/dev/null | grep -q "ollama.*started"; then
    echo "  Registering Ollama to start on boot..."
    brew services start ollama 2>&1 || {
      echo "  ⚠ brew services failed. You can start Ollama manually: ollama serve"
      echo "  Or add it to Login Items in System Preferences."
    }
    echo "  ✓ Ollama will auto-start on boot"
  else
    echo "  ✓ Ollama already registered as a boot service"
  fi
fi

NODE_VERSION=$(node --version | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
  echo "ERROR: Node.js 18+ required (found v$NODE_VERSION)"
  exit 1
fi
echo "  ✓ Node.js version: $(node --version)"
echo "  ✓ Python version: $(python3 --version)"
echo ""

# ---------------------------------------------------------------------------
# STEP 1: Install CodeGraph
# ---------------------------------------------------------------------------
echo "--- Step 1: Installing CodeGraph ---"
echo ""
echo "CodeGraph provides: symbol search, caller/callee tracing, impact analysis"
echo "Backend: Tree-sitter + SQLite (100% local, no API calls)"
echo ""

# Install globally
npm install -g @colbymchenry/codegraph 2>&1 || {
  echo "WARNING: Global install failed. Trying npx approach..."
}

# Verify installation
if command -v codegraph &>/dev/null; then
  echo "  ✓ CodeGraph installed globally"
else
  echo "  ℹ CodeGraph will run via npx @colbymchenry/codegraph"
fi

echo ""

# ---------------------------------------------------------------------------
# STEP 2: Install Cognee MCP
# ---------------------------------------------------------------------------
echo "--- Step 2: Installing Cognee MCP ---"
echo ""
echo "Cognee provides: knowledge graphs, cross-session memory, semantic search"
echo "Backend: KuzuDB (graph) + LanceDB (vectors) + SQLite (relational)"
echo "         All in-process — no Docker, no external databases"
echo ""

# Clone cognee if not already present
if [ -d "$COGNEE_DIR" ]; then
  echo "  ℹ Cognee directory exists at $COGNEE_DIR"
  echo "  Pulling latest changes..."
  cd "$COGNEE_DIR"
  git pull origin main 2>&1 || echo "  ⚠ Git pull failed (may be fine if manually placed)"
else
  echo "  Cloning cognee repository..."
  git clone --depth 1 https://github.com/topoteretes/cognee.git "$COGNEE_DIR-full" 2>&1

  # We only need the cognee-mcp subdirectory, but clone the whole repo
  # because cognee-mcp depends on the parent cognee package
  mv "$COGNEE_DIR-full" "$COGNEE_DIR"
fi

cd "$COGNEE_DIR/cognee-mcp"

# Install dependencies with uv
# Pin to Python 3.12 — onnxruntime (Cognee dependency) doesn't support 3.14 yet.
# uv will auto-download 3.12 if not already installed.
echo "  Installing Python dependencies (pinning to Python 3.12)..."
uv python install 3.12 2>&1 || true
# Patch pyproject.toml to remove postgres/neo4j extras (we use SQLite + KuzuDB + LanceDB).
# Upstream cognee-mcp hardcodes cognee[postgres,docs,neo4j] which needs pg_config to build.
if grep -q 'cognee\[postgres' "$COGNEE_DIR/cognee-mcp/pyproject.toml" 2>/dev/null; then
  echo "  Patching pyproject.toml to remove postgres/neo4j extras..."
  sed -i.bak 's|"cognee\[postgres,docs,neo4j\]|"cognee[docs]|' "$COGNEE_DIR/cognee-mcp/pyproject.toml"
fi

# Regenerate lockfile after patching, then install.
uv lock --python 3.12 2>&1 || true
uv sync --python 3.12 --dev 2>&1

echo "  ✓ Cognee MCP installed (Python 3.12)"
echo ""

# ---------------------------------------------------------------------------
# STEP 3: Configure Cognee environment
# ---------------------------------------------------------------------------
echo "--- Step 3: Configuring Cognee ---"

COGNEE_ENV="$COGNEE_DIR/cognee-mcp/.env"

if [ -f "$COGNEE_ENV" ]; then
  echo "  ℹ .env file already exists. Skipping creation."
  echo "  Review it at: $COGNEE_ENV"
else
  # Prompt for Anthropic API key
  echo ""
  echo "  Cognee needs an Anthropic API key for entity extraction."
  echo "  (It uses Claude for building knowledge graphs from your code/docs.)"
  echo ""

  # Check if ANTHROPIC_API_KEY is already set in environment
  if [ -n "${ANTHROPIC_API_KEY:-}" ]; then
    echo "  ✓ Found ANTHROPIC_API_KEY in environment"
    LLM_KEY="$ANTHROPIC_API_KEY"
  else
    read -p "  Enter your Anthropic API key (sk-ant-...): " LLM_KEY
  fi

  # Configure embedding provider based on Ollama availability
  if [ "$OLLAMA_AVAILABLE" = true ]; then
    EMBED_BLOCK="# Embedding Configuration (Ollama — local, no API cost)
# Anthropic does NOT have an embeddings API, so we use Ollama locally.
EMBEDDING_PROVIDER=ollama
EMBEDDING_MODEL=nomic-embed-text:latest
EMBEDDING_ENDPOINT=http://localhost:11434/api/embed
EMBEDDING_DIMENSIONS=768"
  else
    echo ""
    echo "  ⚠ Ollama not available for embeddings."
    echo "  Falling back to fastembed (CPU-only local embeddings)."
    echo "  This is slower but requires no external service."
    EMBED_BLOCK="# Embedding Configuration (fastembed — CPU-only local, no API cost)
# Anthropic does NOT have an embeddings API, so we use fastembed locally.
# Requires: pip install fastembed (and Python < 3.13)
EMBEDDING_PROVIDER=fastembed
EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2
EMBEDDING_DIMENSIONS=384"
  fi

  cat > "$COGNEE_ENV" <<ENVEOF
# Cognee MCP Configuration — Anthropic + Local Embeddings
# Generated by setup-mcp-stack.sh on $(date)
#
# Architecture:
#   LLM:        Anthropic Claude (entity extraction, graph building)
#   Embeddings: Ollama nomic-embed-text (local, no API cost)
#   Graph DB:   KuzuDB (in-process, zero config)
#   Vector DB:  LanceDB (in-process, zero config)
#   Relational: SQLite (in-process, zero config)

# LLM Configuration (Anthropic)
LLM_PROVIDER=anthropic
LLM_API_KEY=$LLM_KEY
LLM_MODEL=claude-sonnet-4-20250514
LLM_TEMPERATURE=0.0
LLM_MAX_COMPLETION_TOKENS=16384

$EMBED_BLOCK

# Database backends (all in-process, zero config)
DB_PROVIDER=sqlite
GRAPH_DATABASE_PROVIDER=kuzu
VECTOR_DB_PROVIDER=lancedb

# Local settings
ENV=local
TOKENIZERS_PARALLELISM=false
ACCEPT_LOCAL_FILE_PATH=True
ALLOW_HTTP_REQUESTS=True
REQUIRE_AUTHENTICATION=False

# Data storage
DATA_ROOT_DIRECTORY=$CLAUDE_DIR/cognee-data
SYSTEM_ROOT_DIRECTORY=$CLAUDE_DIR/cognee-data/system

# Cross-session memory: learned lessons and architecture decisions persist here.
# Safe to back up / version control the cognee-data directory.
ENVEOF

  # Create data directory
  mkdir -p "$CLAUDE_DIR/cognee-data/system"
  echo "  ✓ Created .env at: $COGNEE_ENV"
  echo "  ✓ Data directory: $CLAUDE_DIR/cognee-data/"
fi

echo ""

# ---------------------------------------------------------------------------
# STEP 4: Add MCP servers to Claude Code settings
# ---------------------------------------------------------------------------
echo "--- Step 4: Configuring Claude Code MCP servers ---"

SETTINGS_FILE="$CLAUDE_DIR/settings.json"

if [ ! -f "$SETTINGS_FILE" ]; then
  echo "  ERROR: settings.json not found at $SETTINGS_FILE"
  exit 1
fi

# Use Python to safely merge MCP config into settings.json
python3 << 'PYEOF'
import json
import os

settings_path = os.path.expanduser(os.environ.get("CLAUDE_CONFIG_DIR", os.path.expanduser("~/.claude"))) + "/settings.json"
cognee_dir = os.path.expanduser(os.environ.get("CLAUDE_CONFIG_DIR", os.path.expanduser("~/.claude"))) + "/cognee-mcp/cognee-mcp"

with open(settings_path, 'r') as f:
    settings = json.load(f)

# Add mcpServers if not present
if 'mcpServers' not in settings:
    settings['mcpServers'] = {}

# CodeGraph MCP
settings['mcpServers']['codegraph'] = {
    "command": "npx",
    "args": ["-y", "@colbymchenry/codegraph", "--mcp"],
    "disabled": False
}

# Cognee MCP (stdio mode for direct integration)
# Env vars are loaded from .env file by cognee, but we pass critical ones here too.
# --python 3.12 ensures we use the compatible Python (onnxruntime needs <=3.13).
settings['mcpServers']['cognee'] = {
    "command": "uv",
    "args": [
        "--directory",
        cognee_dir,
        "run",
        "--python", "3.12",
        "cognee-mcp"
    ],
    "env": {
        "ENV": "local",
        "TOKENIZERS_PARALLELISM": "false",
        "LLM_PROVIDER": "anthropic"
    },
    "disabled": False
}

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)

print("  ✓ Added CodeGraph MCP server to settings.json")
print("  ✓ Added Cognee MCP server to settings.json")
PYEOF

echo ""

# ---------------------------------------------------------------------------
# STEP 5: Add permissions for MCP tools
# ---------------------------------------------------------------------------
echo "--- Step 5: Adding MCP tool permissions ---"

python3 << 'PYEOF'
import json
import os

settings_path = os.path.expanduser(os.environ.get("CLAUDE_CONFIG_DIR", os.path.expanduser("~/.claude"))) + "/settings.json"

with open(settings_path, 'r') as f:
    settings = json.load(f)

allow = settings.get('permissions', {}).get('allow', [])

mcp_permissions = [
    "mcp__codegraph__*",
    "mcp__cognee__*",
]

added = []
for perm in mcp_permissions:
    if perm not in allow:
        allow.append(perm)
        added.append(perm)

settings['permissions']['allow'] = allow

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)

if added:
    for p in added:
        print(f"  ✓ Added permission: {p}")
else:
    print("  ℹ Permissions already present")
PYEOF

echo ""

# ---------------------------------------------------------------------------
# STEP 6: Verify
# ---------------------------------------------------------------------------
echo "--- Step 6: Verification ---"
echo ""

# Verify settings.json is valid
python3 -c "import json; json.load(open('$SETTINGS_FILE')); print('  ✓ settings.json is valid JSON')" || {
  echo "  ERROR: settings.json is invalid!"
  exit 1
}

# Check MCP servers in config
python3 << 'PYEOF'
import json, os
settings_path = os.path.expanduser(os.environ.get("CLAUDE_CONFIG_DIR", os.path.expanduser("~/.claude"))) + "/settings.json"
with open(settings_path) as f:
    s = json.load(f)
servers = s.get('mcpServers', {})
for name, config in servers.items():
    status = "disabled" if config.get("disabled") else "enabled"
    print(f"  ✓ MCP server '{name}': {status}")
PYEOF

echo ""
echo "=========================================="
echo "  Setup Complete!"
echo "=========================================="
echo ""
echo "NEXT STEPS:"
echo ""
echo "  1. Restart Claude Code to pick up the new MCP servers"
echo ""
echo "  2. Index your first project with CodeGraph:"
echo "     cd ~/Desktop/Nua-Labs/AI-Assist"
echo "     npx @colbymchenry/codegraph init"
echo ""
echo "  3. Build a knowledge graph with Cognee:"
echo "     In Claude Code, say: 'Run codify on this codebase'"
echo "     Or: 'cognify these architecture docs'"
echo ""
echo "  4. Search your knowledge graph:"
echo "     'Search cognee for authentication patterns'"
echo "     'What did we learn about the data pipeline?'"
echo ""
echo "  5. Use CodeGraph for code navigation:"
echo "     'Who calls the process_document function?'"
echo "     'What's the impact of changing the BaseAgent class?'"
echo ""
echo "LOG: $LOG_FILE"
echo ""
