#!/bin/bash
if [ -z $1 ]; then
	ipv4=`ifconfig wlan0 | grep "inet " | awk '{print $2}'`;
	ipv6=`ifconfig wlan0 | grep "inet6 " | awk '{print $2}'`;
	iptables -A INPUT -i wlan0 -p udp --dport 53 -j ACCEPT;
	#iptables -A INPUT -i wlan0 -p tcp --dport 443 -j DROP;
	iptables -A INPUT -i wlan0 ! -s $ipv4;
	iptables -t nat -A PREROUTING -i wlan0 -p udp --dport 53 -j DNAT --to-destination $ipv4:53;
	iptables -t nat -A PREROUTING ! -s $ipv4;
	#iptables -t nat -A OUTPUT -p tcp --dport 80 -j DNAT --to-destination $ipv4:8080;
	#iptables -t nat -A OUTPUT ! -s $ipv4;
	iptables -t nat -A POSTROUTING ! -s $ipv4 -j MASQUERADE;
	iptables -t nat -A POSTROUTING -j MASQUERADE;
else
	iptables -F;
	iptables -t nat -F;
fi;
