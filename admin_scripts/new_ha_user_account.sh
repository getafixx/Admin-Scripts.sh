#!/bin/bash

# new_ha_user_account.sh 
#
source setup_base_vars.sh

source message_functions.sh

source account_functions.sh

# This script must be run as root.
#
ROOT_UID=0         # Root has $UID 0.
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo; echo "Only root can run this script."; echo
  exit $E_WRONG_USER
fi

if [ $# -ne 1 ]
then
    about_help
    exit 1
else
    username=$1

    check_username_length $username $USERNAMEMAXLEN
    
    # Check if username exists.
    ret=false
    getent passwd $1 >/dev/null 2>&1 && ret=true
    if $ret; 
    then
        error_message "user $username already exists"
        exit 1;
    else
        
        # add the user
        echo "Creating user $username"
        useradd $username

        # this password technique comes from 
        # http://tldp.org/LDP/abs/html/system.html
        # generate new password 15 chars long...
        echo "Creating user password"
        NEWPASSWORD=$(randpass 15 1)
        echo "$NEWPASSWORD" | passwd --stdin "$username"
        #  The '--stdin' option to 'passwd' permits
        #+ getting a new password from stdin (or a pipe). 
        
        userhome=$home_root$username"/"
        if [ -d "$userhome" ]
        then
            # I have set up a home dir template and it sits in home.tar
            # extract to new user home folder
            echo "setting up user directory files"
            tar xvf home_base_template.tar -C $userhome
            # set the correct ownership and permissions
            echo "setting up the correct ownership and permissions on new files"
            chown -R $username.$username $userhome
            find $userhome -type d -print -exec  chmod -R 775 {} \;
            find $userhome -type f -print -exec  chmod -R 660 {} \;
            
            
            usershared=$shared_root$username"/"
            usersharedphpsessions=$usershared"phpsessions"

            if [ ! -d "$usershared" ]
            then
                echo "creating $usershared"
                #add the a folder for the user to the shared folder
                mkdir "/shared_folder/"$username

                if [ ! -d "$usersharedphpsessions" ]
                then
                    echo "Creating user $usersharedphpsessions"
                    mkdir $usersharedphpsessions
                fi
                chown -R $username.$username "/shared_folder/"$username
            fi

            #This will sync the users on both computers
            echo "syncing users between machines"
            /root/admin_scripts/sync_users.sh

            #this will sybc the /home dirs on both computers (this runs every minute anyway)
            echo "syncing home dirs between machines"
            /root/admin_scripts/sync_home.sh
            
            create_new_user_data_to_file $username $NEWPASSWORD 
            
            display_new_user_data $username

            email_new_user_data $username

           

        else
            error_message "user directory does not exist... something went very wrrong."
        fi

    fi      
fi   

