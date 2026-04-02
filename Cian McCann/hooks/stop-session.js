#!/usr/bin/env node

// Stop hook: Cognee save reminder + session cleanup
//
// Before the session ends, reminds Claude to:
// 1. Save important findings to Cognee (if any significant work was done)
// 2. Update KNOWN_ISSUES.md if bugs were resolved
//
// Also cleans up temp tracking files (edit tracker, context bridge).

const fs = require('fs');
const path = require('path');
const os = require('os');

let input = '';
const timeout = setTimeout(() => process.exit(0), 3000);
process.stdin.setEncoding('utf8');
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
  clearTimeout(timeout);
  try {
    const data = JSON.parse(input);
    const sessionId = data.session_id || '';

    const messages = [];

    // Check if significant work was done (edits tracked)
    if (sessionId) {
      const trackPath = path.join(os.tmpdir(), `claude-edits-${sessionId}.json`);
      if (fs.existsSync(trackPath)) {
        try {
          const tracked = JSON.parse(fs.readFileSync(trackPath, 'utf8'));
          if (tracked.editCount && tracked.editCount >= 3) {
            messages.push(`SESSION END: ${tracked.editCount} code edits across ${tracked.files.length} files this session.`);
            messages.push('If you made architecture decisions, fixed non-trivial bugs, or discovered important patterns — use Cognee `save_interaction` to persist them before this context is lost.');
          }
        } catch (e) {}

        // Clean up tracking file
        try { fs.unlinkSync(trackPath); } catch (e) {}
      }

      // Clean up context bridge file
      try {
        const ctxPath = path.join(os.tmpdir(), `claude-ctx-${sessionId}.json`);
        if (fs.existsSync(ctxPath)) fs.unlinkSync(ctxPath);
      } catch (e) {}

      try {
        const warnPath = path.join(os.tmpdir(), `claude-ctx-${sessionId}-warned.json`);
        if (fs.existsSync(warnPath)) fs.unlinkSync(warnPath);
      } catch (e) {}
    }

    if (messages.length > 0) {
      process.stdout.write(JSON.stringify({
        additionalContext: messages.join(' ')
      }));
    }

  } catch (e) {
    // Fail open
  }
  process.exit(0);
});
