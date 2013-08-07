#/bin/bash

cd /etc
scp -P 5522 passwd group gshadow shadow root@jxt01-www12:/etc/

