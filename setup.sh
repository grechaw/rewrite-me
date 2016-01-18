#!/bin/bash

USERNAME=admin
PASSWORD=admin
CURL="curl -X PUT --digest --user $USERNAME:$PASSWORD"
PWD=`pwd`

## setup the database and apperserver.
perl -pe"\$p = '$PWD'; s/XXXXXXX/\$p/g" server-raw.json > server.json
perl -pe"\$p = '$PWD'; s/XXXXXXX/\$p/g" yup-raw.xqy > yup.xqy

# these two steps enable the triples index and can set the inference
# Really only needs to be done once
echo "copy to new-root"
cp yup.xqy new-root
echo "putting module to modules database"
$CURL -Hcontent-type:application/xquery --data-binary @yup.xqy "http://localhost:8000/v1/documents?database=Modules&uri=/yup.xqy"
$CURL -Hcontent-type:application/xquery --data-binary @yup.xqy "http://localhost:8000/v1/documents?database=Modules&uri=/new-root/yup.xqy"
