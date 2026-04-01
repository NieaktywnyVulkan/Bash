#!/bin/bash
IP=$(hostname -I | awk '{print $1}')
RAM=$(free -m | awk '/Mem:/ {print $2}')
CPU=$(grep -c ^processor /proc/cpuinfo)
echo "IP: $IP"
echo "RAM: $RAM"
echo "CPU: $CPU"