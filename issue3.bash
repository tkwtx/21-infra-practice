#! /bin/bash

TODAY=`date +%Y%m%d`
FIVEDAYSAGO=`date --date '5 days ago' +%Y%m%d`
DIR="/home/menta/sql_backup"
EXT="dump"

mysqldump --single-transaction -u root -p wordpress > ${DIR}/${TODAY}.${EXT}

for FILENAME in ${DIR}/*.${EXT}; do
	TARGET=`basename ${FILENAME} .${EXT}`
	if [ ${FIVEDAYSAGO} -gt ${TARGET} ]
	then 
		rm ${DIR}/${TARGET}.${EXT}
	fi
done