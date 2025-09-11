#!/bin/bash
#set -x 

#mail sending function 
function sendmail()
{
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [INFO] - Sending Mail."
    fileCheck
    echo -e "Hi Team , \n\n Please find the attached file requested \n\n Thanks. "|mail -s "File Transfer" -a ${attachment} ${receiverMail}
}

#Checking For File
function fileCheck()
{
    if [[ -f ${attachment} ]];
    then 
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [INFO] - File is available."
    else
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [ERROR] - File is not available."
    exit 1
    fi
}

#main function

while [ -n "$1" ]; do 
    case $1 in 
    -file ) attachment=$2
    shift
    ;;
    -to ) receiverMail=$2
    shift
    ;;
    * ) echo -e "Invalid Option passed : $1"
    esac
    shift
done


#passcheck

KEYWORD="pass|password|cred|credentials|.p12|.pem|.key|.jks"

if grep -iE "${KEYWORD}" "${attachment}" >/dev/null ; then
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [ERROR] - File is contains sensitve information. Cannot Send the file."
    exit 1 
fi 

sendmail

'''
How to use the script

/bin/bash ./mail.sh -file <PATH_TO_FILE/FILENAME.txt> -to <mailID>
/bin/bash ./mail.sh -file /tmp/MyFile.txt -to "user1@mail.com  user2@mail.com"
'''
