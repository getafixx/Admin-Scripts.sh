#!/bin/bash

source message_functions.sh

function new_user_data_filename
{
    username=$1
    filename="/root/admin_scripts/useraccounts/"$username".txt"
    echo $filename
}

function admin_users_filename
{
    filename="/root/admin_scripts/admin_users_file.txt"
    echo $filename
}
function create_new_user_data_to_file
{
    username=$1
    password=$2
    filename=$(new_user_data_filename $username)
    NOW=$(date +"%d - %M - %Y")

    echo "+===================================+" > $filename
    echo "| New JXT HA Account Info           |" >> $filename
    echo "+===================================+" >> $filename
    echo "| Ip: 113.192.21.104 (n)" >> $filename
    echo "| UserName: $username" >> $filename
    echo "| PassWord: $password" >> $filename
    echo "| HomeRoot: /home" >> $filename
    echo "| Quota: unlimited" >> $filename
    echo "| Contact Email: support@jxt.com.au" >> $filename
    echo "+===================================+" >> $filename
    echo "">> $filename
    echo "Created on $NOW">> $filename
}


function email_new_user_data
{
    username=$1
    filename=$(new_user_data_filename $username)
    subject="New JXT HA Account Info for $username"

    admin_users_file=$(admin_users_filename)
    #echo "admin users file = $admin_users_file"
    while read line
    do
          #echo "Mailing user data to -> $line"      
          cat $filename | mail -s "$subject" $line
    done < $admin_users_file

}


about_help
message "this is a message"
error_message "this is a error_message"

