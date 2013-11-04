#!/bin/bash
#  Generate a random password
#  $1 = number of characters; defaults to 32
#  $2 = include special characters; 1 = yes, 0 = no; defaults to 1
#  
#  http://www.legroom.net/2010/05/06/bash-random-password-generator
function randpass() 
{
  [ "$2" == "0" ] && CHAR="[:alnum:]" || CHAR="[:graph:]"
    cat /dev/urandom | tr -cd "$CHAR" | head -c ${1:-32}
}


function new_user_data_filename
{
    username=$1
    filename=$useraccounts$username".txt"
    echo $filename
}
function deleted_user_data_filename
{
    username=$1
    filename=$useraccounts"deleted_"$username".txt"
    echo $filename
}

function admin_users_filename
{
    filename=$admin_scripts"admin_users_emails.txt"
    echo $filename
}

function create_new_user_data_to_file
{
    username=$1
    password=$2
    filename=$(new_user_data_filename $username)
    NOW=$(date +"%d - %m - %Y")

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

function delete_user_data_to_file
{
    username=$1
    filename=$(deleted_user_data_filename $username)
    NOW=$(date +"%d - %m - %Y")

    echo "+===================================+" > $filename
    echo "| Deleted JXT HA Account Info       |" >> $filename
    echo "+===================================+" >> $filename
    echo "| UserName: $username" >> $filename
    echo "+===================================+" >> $filename
    echo "">> $filename
    echo "Created on $NOW">> $filename
}

function email_admin_user_about_account_deleted
{
    username=$1
    subject="JXT HA Account $username deleted"

    admin_users_file=$(admin_users_filename)
    #echo "admin users file = $admin_users_file"
    while read line
    do
        #echo "Mailing user data to -> $line"      
        mail -s "$subject" $line
    done < $admin_users_file

}

function display_new_user_data
{
    username=$1
    filename=$(new_user_data_filename $username)
    mapfile < $filename
    echo "${MAPFILE[@]}"
}

function check_username_length
{
    username=$1
    MAXLEN=$2
    length=${#username}
    #echo "Checking username $username $MAXLEN testing - $length"
    
    if [ "$length" -gt "$MAXLEN" ]
    then
        error_message "'$username' username too long it is $length long  - Max length is $MAXLEN - please try again"
        exit -1
    else
        echo "username length OK"
    fi
}