#!/bin/bash
# Sửa lỗi apt: thay đổi mirror an toàn mà không làm mất từ khóa "deb"
apt-get update || (sed -i 's|http://.*archive.ubuntu.com|http://ports.ubuntu.com|g' /etc/apt/sources.list && apt-get update)

apt-get install -y --fix-missing libjansson4 libomp5 wget screen

killall screen 2>/dev/null
rm -rf ccminer config.json

wget -q https://github.com/hotrantien/CC-miner-ARM/releases/download/v1.0.0/ccminer
chmod +x ccminer

# Tạo tự động file config.json với 3 pool fallback
cat <<EOF > config.json
{
  "algo": "verus",
  "threads": $(nproc),
  "retries": 3,
  "retry-pause": 10,
  "timeout": 60,
  "pools": [
    {
      "name": "Primary Pool (US West)",
      "url": "stratum+tcp://usw.vipor.net:5040",
      "user": "RPnfxAiP23QFzEGtt5gwwrbZiD3uZqjper.OracleARM",
      "pass": "x"
    },
    {
      "name": "Fallback 1 (Canada)",
      "url": "stratum+tcp://ca.vipor.net:5040",
      "user": "RPnfxAiP23QFzEGtt5gwwrbZiD3uZqjper.OracleARM",
      "pass": "x"
    },
    {
      "name": "Fallback 2 (Germany)",
      "url": "stratum+tcp://de.vipor.net:5040",
      "user": "RPnfxAiP23QFzEGtt5gwwrbZiD3uZqjper.OracleARM",
      "pass": "x"
    },
    {
      "name": "Fallback 3 (US)",
      "url": "stratum+tcp://us.vipor.net:5040",
      "user": "RPnfxAiP23QFzEGtt5gwwrbZiD3uZqjper.OracleARM",
      "pass": "x"
    }
  ]
}
EOF

# Chạy ccminer với file config.json trong screen
screen -dmS miner ./ccminer -c config.json
