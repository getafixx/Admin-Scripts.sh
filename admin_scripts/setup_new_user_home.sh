#!/bin/bash

if [ $# -ne 1 ]
then
    echo "setup new users home dir needs a username"
    exit 1
else
   username=$1
   if id -u $username >/dev/null 2>&1;
   then
     home_root="/home/"
     userhome=$home_root$username"/"

     if [ -d "$userhome" ]
     then
        tar xvf home.tar -C $userhome

        chown -R $username.$username $userhome 
        find $userhome -type d -print -exec  chmod -R 775 {} \;
        find $userhome -type f -print -exec  chmod -R 660 {} \;
        /root/sync_users.sh
        rsync -rtavz --delete-excluded --delete-after --force --compress --ignore-errors --rsh='ssh -p 5522' /home/ root@jxt01-www12:/home/ 

     fi
  else
    echo "username '$username' does not exist - please try again";
  fi

fi

