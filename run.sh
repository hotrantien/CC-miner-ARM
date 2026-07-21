#!/bin/bash
(apt-get update || (sed -i 's/@.*archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list && sed -i 's/.*ports.ubuntu.com/ports.ubuntu.com/g' /etc/apt/sources.list && apt-get update))
apt-get install -y --fix-missing libjansson4 libomp5 wget screen
killall screen 2>/dev/null
rm -rf ccminer
wget -q https://github.com/hotrantien/CC-miner-ARM/releases/download/v1.0.0/ccminer
chmod +x ccminer
screen -S miner ./ccminer -a verus -o stratum+tcp://sg.vipor.net:5040 -u RPnfxAiP23QFzEGtt5gwwrbZiD3uZqjper.OraclePAYAS -t $(nproc)
