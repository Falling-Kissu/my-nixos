#!/usr/bin/env bash
# Check for the three pillars of ActivityWatch
echo "--- ActivityWatch Status ---"
processes=("aw-server" "aw-watcher-window" "aw-watcher-afk")

for proc in "${processes[@]}"; do
    if pgrep -f "$proc" > /dev/null; then
        echo "✅ $proc is RUNNING"
    else
        echo "❌ $proc is MISSING"
    fi
done
echo "----------------------------"
echo "Web UI: http://localhost:5600"
