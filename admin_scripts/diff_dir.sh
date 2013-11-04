#!/bin/bash
dir=$1
diff -q /home/changetr/public_html/stg-ent/bia/$1 /home/changetr/public_html/enterprise/bia/$1 |sort
