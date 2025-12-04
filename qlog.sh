#!/bin/sh
config_file=/etc/config/qpkg.conf

version=$(awk '/\[helpdesk\]/ {found=1} found && /Version/ {print $3; exit}' "$config_file")

ver_to_num() {
    IFS='.' read -r major minor patch <<< "$1"
    printf "%03d%03d%03d\n" "$major" "$minor" "$patch"
}

YELLOW='\033[1;33m'
RESET='\033[0m'
echo -e
echo "Start dump NAS log by helpdssk command"
echo -e
#cd /
/mnt/ext/opt/qdesk/www/data/script/get_log $(get_hwsn)
echo -e
# echo "Helpdesk version is: $version"
echo -e "Helpdesk version is: ${YELLOW}${version}${RESET}"
echo -e

if [ "$(ver_to_num "$version")" -ge "$(ver_to_num "3.3.3")" ]; then
    echo "NAS log file store in /mnt/diag"
	qdesk upload /mnt/diag/$(get_hwsn).zip
	qdesk clean-dumplog run
	rm qlog.sh
else
    echo "NAS log file store in /tmp/helpdump"
	qdesk upload /tmp/helpdump/$(get_hwsn).zip
	rm qlog.sh
fi


