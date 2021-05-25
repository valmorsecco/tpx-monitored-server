#!/bin/bash
###
# basic.sh
# Author: Valmor Secco
# Company: Three Pixels Sistemas
# Description: Basic shellscript to create a monitored server.
###
BASE_GLANCES_WORKSPACE=/srv/www/.tracking/glances/data
BASE_GLANCES_CSV_FILE=$(date +"%Y%m%d%I%M%p%S")
BASE_GLANCES_CSV_FILE_TMP=$BASE_GLANCES_WORKSPACE/$BASE_GLANCES_CSV_FILE.csv.tmp
BASE_GLANCES_CSV_FILE_FULL=$BASE_GLANCES_WORKSPACE/$BASE_GLANCES_CSV_FILE.csv

glances -t 5 -quiet --export csv --export-csv-file $BASE_GLANCES_CSV_FILE_TMP &
pid=$!
sleep 5
kill $pid
mv $BASE_GLANCES_CSV_FILE_TMP $BASE_GLANCES_CSV_FILE_FULL