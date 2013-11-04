#!/bin/bash
function message
{
    echo "-----------------------  INFO  -----------------------"
    echo ""
    echo $1
    echo ""
    echo "-----------------------  INFO  -----------------------"

}
function error_message
{
    echo "####################  ERROR  ####################"
    echo ""
    echo $1
    echo ""
    echo "####################  ERROR  ####################"

}

function about_help
{
    echo "####################  new_ha_user_account setup  ####################"
    echo ""
    echo "new_ha_user_account.sh <username>"
    echo ""
    echo "A random password will be generated for you and output here."
    echo ""
    echo "####################  new_ha_user_account setup  ####################"

}