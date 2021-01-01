#! /bin/bash

DATA=`date +%Y%m%d`
FIVEDAYSAGO=`date --date '5 days ago' +%Y-%m-%d`

mysqldump -u root wordpress wp_posts --where "post_date > '${FIVEDAYSAGO}'"> /home/menta/sql_backup/${DATA}.dump