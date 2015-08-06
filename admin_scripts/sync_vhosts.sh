#/bin/bash

rsync -rtavz --delete-excluded --delete-after --force --compress --ignore-errors --rsh='ssh -p 5522' /etc/httpd/conf/vhosts/ root@jxt01-www12:/etc/httpd/conf/vhosts/

