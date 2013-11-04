#!/bin/bash

source setup_base_vars.sh

source message_functions.sh

source account_functions.sh

#
# most of teh steps in this script have come from \
# 
# http://www.cyberciti.biz/faq/linux-remove-user-command/
#


#
# delete_user_and_account - will delete user and the users home dir
#
function delete_user_and_account
{
    username=$1

    if [ "$username" == "root" ]
    then
      error_message "username is $username - come on you can't delete root.. please try again"
      exit 1
    fi


    if id -u $username >/dev/null 2>&1;
    then
      #home_root="/home/"
      userhome=$home_root$username"/"
      
      #shared_root="/shared_folder/"
      
      usershared=$shared_root$username"/"

      if [ -d "$userhome" ]
      then
          
        message "username looks OK  '$username' OK  - going to try to delete user $username"
        echo "*********** WARNING ***************"
        echo ""
        echo "You are about to delete a user account ($username) and related files from user account located in $userhome."
        echo "This operation cannot be undone, and will not be able to be restored!"
        echo ""
        echo "*********** WARNING ***************"
        echo ""
        echo "Are you sure you want to delete user $username and the users home dir"
        echo ""
        echo "- if YES type (lowercase) yes123! followed by [ENTER]:"
        echo ""
        echo "- if NO then type anything else or nothing followed by [ENTER]:"
        echo ""
        read answer
        if [ "$answer" == "yes123!" ] 
        then
          message "going to try to delete user $username"
              
              echo "locking password"
              passwd -l $username
              
              if [ -d "$usershared" ]
              then
                echo "Removing User shared folder $usershared"
                rm -rf $usershared
              fi

              echo "killing any running processes"

              
              pgrep -u $username
              #ps -fp $(pgrep -u $username)
              killall -KILL -u $username
              echo "Delete at jobs"
              find /var/spool/at/ -name "[^.]*" -type f -user $username -delete
              echo "remove cron jobs"
              crontab -r -u $username
              
              
              
              echo "remove print jobs"
              lprm $username
              #echo "find all files owned by user $username"
              #find / -user $username -print
              
              echo "delete user account"
              userdel -r $username

              message "delete of user $username and files complete"
              
              delete_user_data_to_file $username

              email_admin_user_about_account_deleted $username
          else
            message "Aborting - not deleting user $username"
          fi
        fi
    else
      error_message "username '$username' does not exist - please try again";
    fi
}

if [ $# -ne 1 ]
then
    error_message "Delete user and their home dir needs a 'username' - come on what do you want me to do!"
    exit 1
else
  delete_user_and_account $1
  exit 1
fi



