#!/bin/bash

cpu_info(){
	local architecture=$(uname -m)
	local cpu=$(lscpu | grep "Model name" | sed 's/.*: *//')
	echo "CPU\n$architecture architecture \n$cpu\n"
}

ram_info(){
	local ramSize=$(cat /proc/meminfo |grep MemTotal | awk '{print $2/(1024^2)}')
	echo "RAM\nSize is $ramSize GB\n"

}

card_info(){
	local card=$(lspci | grep Network | awk -F ':' '{print $3}')
	local ip=$(hostname -I | awk '{print $1}')
	echo "Network\nCard $card\nIP address $ip\n"

}

engine(){
        echo 'Print info about CPU, RAM or Network? (enter the name, sequence number or initial)'
        read hardware
	case $hardware in
		CPU|cpu|1|C|c)
			cpu_info
			;;
		RAM|ram|2|R|r)
			ram_info
			;;
		Network|Net|net|3|N|n)
			card_info
			;;
	esac
}

engine
