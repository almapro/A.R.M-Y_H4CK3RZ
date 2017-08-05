#!/bin/bash
openssl req -config `pwd`/ssl.conf -new -x509 -sha256 -newkey rsa:2048 -nodes -keyout `pwd`/lh.key.pem -days 365 -out `pwd`/lh.cert.pem
