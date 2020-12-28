#! /bin/bash

PROCESS_NAME=nginx

RESULT=`pgrep -fl $PROCESS_NAME | wc -l`

if [[ ${RESULT} =~ ^0$ ]]
then
	sudo systemctl start $PROCESS_NAME
	echo "${PROCESS_NAME} is not running,${PROCESS_NAME} is running"
else
	echo "${PROCESS_NAME} is running"
fi