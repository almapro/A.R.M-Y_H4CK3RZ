#!/bin/bash
ipv4=`ifconfig wlan0 | grep "inet " | awk '{print $2}'`
ipv6=`ifconfig wlan0 | grep "inet6 " | awk '{print $2}'`
#cat /etc/resolv.conf > /tmp/resolv.conf;
#echo nameserver "$ipv4" > /etc/resolv.conf;
#cat /root/Desktop/AlMAPRO/conf-dnschef.txt | sed s/"_IPv4_"/"$ipv4"/g | sed s/"_IPv6_"/"$ipv6"/g > /tmp/dnschef.conf;
/root/Desktop/AlMAPRO/iptables.sh;
dnschef --file conf-dnschef.txt --fakeip $ipv4 --fakeipv6 $ipv6 --fakemail $ipv6 --fakealias $ipv6 --fakens $ipv6 -i 0.0.0.0;
/root/Desktop/AlMAPRO/iptables.sh 1;
#cat /tmp/resolv.conf > /etc/resolv.conf;
