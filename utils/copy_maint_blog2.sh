#/bin/bash

function error_message
{
    echo "####################  ERROR  ####################"
    echo ""
    echo $1
    echo ""
    echo "####################  ERROR  ####################"

}

if [ $# -ne 1 ]
then
    echo "####################  ERROR  ####################"
    echo ""
    echo '$0 user';
    echo 'eg : $0 sabalawy';
    echo ""
    echo "####################  ERROR  ####################"
    exit 1
else
    username=$1
    blog_path_part=$2
    blog_path="/home/"$username"/public_html/blog2/"

    content_path="/home/jobxwiki/public_html/wp_maint";
  
	echo ""
    echo "####################  Starting ####################"
    echo ""	    
    CMD="cp $content_path/index.php "$blog_path;
	echo "$CMD";
	$CMD;
	CMD="chown "$username"."$username" "$blog_path"index.php";
	echo "$CMD";
	$CMD;
    echo ""
    echo "####################  DONE ####################"
    echo ""
	exit 1
	
 fi