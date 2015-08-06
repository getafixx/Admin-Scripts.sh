#/bin/bash

count=$#

if [ $# -eq 3 ]
then
    echo '$0 domain user pass'
    exit 1
else
        echo "Only root may add a user to the system"
        exit 2

 fi

