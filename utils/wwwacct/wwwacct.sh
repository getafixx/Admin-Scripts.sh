#!/bin/bash

#wwwacct <domain> <user> <pass>
if [ $# -ne 3 ]
then
    echo 'wwwacct domain user pass'
    exit 1
else
    set domain = $1
    set username = $2
    set password = $3

    echo "$0 Running $domain $username $pass \n"

    # Script to add a user to Linux system

    if [ $(id -u) -eq 0 ]
    then
        #read -p "Enter username : " username
        #read -s -p "Enter password : " password
        egrep "^$username" /etc/passwd >/dev/null

    	if [ $? -eq 0 ]
    	then
                echo "$username exists!"
                exit 1
        else
            pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
            useradd -m -p $pass $username

    	    if [ $? -eq 0 ]
    	    then

                    echo "User has been added to system! - creating home DIR"
                    cd /home/$username/
                    tar xfv ~/home.tar .


                    #touch CustomLogs
                    /home/$username/logs/$domain-bytes_log "%{%s}t %I .\n%{%s}t %O ."
                    /home/$username/logs/$domain combined

    		        chown -R $username.$username .

                    #create vhosts file
                    #$username.vhosts

                    if [ -e "/etc/httpd/conf/httpd.conf_" ]
                    then
                        unlink "/etc/httpd/conf/httpd.conf_"
                    #copy http conf file
                    #cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_
                    # add new vhosts file to end
                    #cat /etc/httpd/conf/httpd.conf_ /home/$username/$username.vhosts > /etc/httpd/conf/httpd.conf
                    fi

            else
                echo "Failed to add a user!"
            fi

        fi
    fi
fi

