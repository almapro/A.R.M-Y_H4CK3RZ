#!/bin/bash
if [ -z $1 ]; then
	echo We need a host to browse! Right?;
	exit 1;
fi;
if [ -z $2 ]; then
	echo We need remote port!;
	exit 1;
fi;
if [ -z $3 ]; then
	echo We need local port!
	exit 1;
fi;
res=`netstat -lnp | grep :9050 | grep tor`;
if [ "$res" == "" ]; then
	tor=`which tor`;
	if [[ "$tor" == *"/tor"* ]]; then
		echo TOR does not exist! Please install TOR using apt!;
		exit 1;
	else
		echo TOR is not running!;
		exit 1;
	fi;
fi;
socat TCP4-LISTEN:$3,reuseaddr,fork SOCKS4A:127.0.0.1:$1:$2,socksport=9050
