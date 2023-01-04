#!/bin/bash

dir="/home/ali/bsm/test"


db_host="localhost"
db_user="postgres"
db_name="scanned"

snapshot=$(ls $dir)

while :
do
	new_snapshot=$(ls $dir)

	datas=$(diff <(echo "$snapshot") <(echo "$new_snapshot"))

	if [ "$datas" != "" ]
	then
	#Table->datas Column1->file_details Column2->file_details2
		psql -h $db_host -U $db_user -d $db_name <<EOF
		INSERT INTO datas VALUES ('$datas');
EOF
	snapshot=$new_snapshot
	fi


	#Her 10 saniyede kontrol
	sleep 10
done