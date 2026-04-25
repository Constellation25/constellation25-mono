#!/data/data/com.termux/files/usr/bin/bash
echo "🌟 constellation25-mono"
curl -s http://localhost:3000/api/proxy > /dev/null && echo "✅ PATHOS"
echo "[constellation25-mono] $(date)" >> "/data/data/com.termux/files/home/sovereign_gtp/logs/constellation25-mono.log"
