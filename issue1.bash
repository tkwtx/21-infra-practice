#! /bin/bash

PROCESS_NAME=nginx

RESULT=`ps -ef | grep ${PROCESS_NAME} | grep -v grep | wc -l`

if [[ ${RESULT} =~ [^1-9] ]]
then
	sudo systemctl start $PROCESS_NAME
	echo "${PROCESS_NAME} is not running,$PROCESS_NAME is running"
else
	echo "${PROCESS_NAME} is running"
fi