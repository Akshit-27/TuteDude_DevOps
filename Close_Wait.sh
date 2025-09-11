#!/bin/bash
#set -x 

#configurations
R_EMAIL="Akshit@mail.com"
SUBJECT="ALERT!! : Close Wait Connections Report from $(hostname) generated at `date +"%A, %D, %T"`. "
ALERT_MSG=""
INFO_MSG="Hi Team, \n\n No CLOSE_WAITS detected on $(hostname) at `date +"%A, %D, %T"`. "
REPORT_FILE=/tmp/CLOSE_WAIT_REPORT.txt
echo -e "Close Wait Connection Report for `hostname` generated on `date +"%A, %D, %T"`."
echo -e "--------------------------------------------------------------------------------------"

ps -ef|grep -i tibemsd.conf |grep -v 'grep' |awk {'print $10'} |while read line
do 
PORTS=$(grep -i listen $line |grep -v "tcp"|grep -v "#"|awk -F ':' '{ print $NF }')
if [ -n "$PORTS" ]; then
echo -e "--------------------------------------------------------------------------------------"
echo -e "`date '+%m:%d:%y  %H%M%S'`  - [INFO] - Checking Port Number $PORTS for CLOSE WAITS......."
CLOSE_WAITS_OUTPUT=$(netstat -apn| grep -E ":$PORTS\b"|grep -i WAIT)
echo -e "Checking PORT NUMBER : $PORTS" >> "$REPORT_FILE" 2>$1
netstat -apn| grep -E ":$PORTS\b"|grep -i WAIT >> "$REPORT_FILE" 2>$1
echo -e "--------------------------------------------------------------------------------------" >> "$REPORT_FILE" 2>$1
if [ -n "$CLOSE_WAITS_OUTPUT" ]; then 
    ALERT_MSG+="Close_Wait Connections Detected on port $PORTS: \n"
    ALERT_MSG+="$CLOSE_WAITS_OUTPUT\n\n"
    fi
fi
#sending mail
if [ -n "$ALERT_MSG" ]; then 
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [ALERT] - Close Waits Detected on $PORTS. Sending mail to ops team"
    echo -e "$ALERT_MSG"|mail -s "$SUBJECT" Akshit@mail.com
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [INFO] - Mail Sent."
    ALERT_MSG=""
else 
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [INFO] - No Close Waits Detected.."



'''
How to use the script

/bin/bash ./Close_Wait.sh 

'''