#/bin/bash

rsync -rtavz --delete-excluded --delete-after --force --compress --ignore-errors --rsh='ssh -p 5522' /home/ root@jxt01-www12:/home/

