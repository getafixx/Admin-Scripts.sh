#!/bin/bash
url=$1
domain=`expr $url | sed 's/http:\/\///;s|\/.*||'`
domain=`expr $domain | sed 's/www.//;s|\/.*||'`

#$dig1=`dig $domain`

dig $domain A +noall +answer 
dig www.$domain A +noall +answer
dig m.$domain A +noall +answer



