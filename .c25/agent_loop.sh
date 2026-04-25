#!/bin/bash
set -euo pipefail
C25_HOME="${C25_HOME:-$HOME/github-repos/constellation25-mono}"
MAX_AGENTS="${C25_MAX_AGENTS:-3}"
log() { echo "[$(date -u +%H:%M:%S)] $1" >> "$C25_HOME/.c25/agent.log"; }
while true; do
  # Check pending tasks
  TASKS=$(find "$C25_HOME/.c25_tasks/pending" -name "*.json" 2>/dev/null | wc -l)
  [ "$TASKS" -gt 0 ] && log "ℹ️ Pending tasks: $TASKS"
  # Run up to MAX_AGENTS
  RUNNING=$(pgrep -f "c25_agent_" 2>/dev/null | wc -l)
  if [ "$RUNNING" -lt "$MAX_AGENTS" ]; then
    find "$C25_HOME/.c25_tasks/pending" -name "*.json" -mmin -5 2>/dev/null | head -$((MAX_AGENTS-RUNNING)) | while read -r task; do
      AGENT=$(jq -r '.agent' "$task" 2>/dev/null || echo "Earth")
      TASK_ID=$(jq -r '.task_id' "$task" 2>/dev/null || echo "unknown")
      log "🚀 Starting $AGENT for $TASK_ID"
      # Placeholder: replace with actual agent execution
      bash -c "echo '[AGENT:$AGENT] Task $TASK_ID executed at $(date)'" >> "$C25_HOME/.c25/agent.log" &
      mv "$task" "${task%.json}.running" 2>/dev/null || true
    done
  fi
  # Heartbeat
  log "♥ Agent runner heartbeat ($(date -u +%H:%M:%S))"
  sleep 60
done
