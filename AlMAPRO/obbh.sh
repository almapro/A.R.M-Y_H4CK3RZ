#!/bin/bash
sleep 5;
numlockx
service postgresql start;
service apache2 start;
pulseaudio -D
service bluetooth start;
service ssh start;
service mysql start;
