#!/bin/sh
touch /var/run/utmp
export TERMINFO='/usr/share/terminfo/'
ln -s /usr/share/terminfo/x/xterm-xfree86 /usr/share/terminfo/x/xterm-256color
ln -s /usr/share/terminfo/x/xterm-xfree86 /usr/share/terminfo/x/xterm-color
