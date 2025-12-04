#!/bin/sh

wget -O screen.sh "https://raw.githubusercontent.com/lunstudy/Q-scripts/refs/heads/main/screen.sh"
wget http://download.qnap.com/Storage/tsd/utility/tp_collect.sh
sh screen.sh

mount_path=$(df -h | awk '$6 ~ /^\/share\/external\/DEV/ {print $6}' | head -n 1)


if [ -z "$mount_path" ]; then
    echo "Can't find any USB HDD"
    exit 1
fi

echo "Find the USB HDD, USB HDD path: $mount_path"
echo

if grep -q "^COLLECT=" tp_collect.sh; then
    sed -i "s|^COLLECT=.*|COLLECT=$mount_path|" tp_collect.sh
else
    echo "COLLECT=\"$mount_path\"" >> tp_collect.sh
fi

echo "Already add USB HDD path into the tp_collect.sh file"
echo
