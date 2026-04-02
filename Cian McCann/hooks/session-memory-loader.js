#!/usr/bin/env node

// SessionStart hook: Report available memory files for this project
// Returns additionalContext listing available .md files in the memory directory

const fs = require('fs');
const path = require('path');

const memoryDir = path.join(
  process.env.HOME,
  '.claude/projects/-Users-cian-Desktop-Nua-Labs--AI-Assist/memory'
);

try {
  if (!fs.existsSync(memoryDir)) {
    process.exit(0);
  }

  const files = fs.readdirSync(memoryDir)
    .filter(f => f.endsWith('.md') && f !== 'MEMORY.md')
    .sort();

  if (files.length === 0) {
    process.exit(0);
  }

  const fileList = files.map(f => `  - ${f}`).join('\n');

  const result = {
    additionalContext: `Available memory files (read on-demand when relevant):\n${fileList}`
  };

  process.stdout.write(JSON.stringify(result));
} catch (e) {
  // Fail open - don't block session start
  process.exit(0);
}
