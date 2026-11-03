#!/bin/sh
echo "Set screen"
touch /var/run/utmp
export TERMINFO='/usr/share/terminfo/'
ln -s /usr/share/terminfo/x/xterm-xfree86 /usr/share/terminfo/x/xterm-256color
ln -s /usr/share/terminfo/x/xterm-xfree86 /usr/share/terminfo/x/xterm-color
echo

echo "Download tp collect tool"

wget http://download.qnap.com/Storage/tsd/utility/tp_collect.sh


echo
echo "Detect USB HDD..."

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