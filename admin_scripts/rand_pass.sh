#!/bin/bash


#  Generate a random password
#  $1 = number of characters; defaults to 32
#  $2 = include special characters; 1 = yes, 0 = no; defaults to 1
#  
#  http://www.legroom.net/2010/05/06/bash-random-password-generator
#  

function randpass() 
{
  [ "$2" == "0" ] && CHAR="[:alnum:]" || CHAR="[:graph:]"
    cat /dev/urandom | tr -cd "$CHAR" | head -c ${1:-32}
    #echo
}


return_var=$(randpass 32 1)
echo "$return_var"