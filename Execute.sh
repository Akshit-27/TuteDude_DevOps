#!/bin/bash
cat /tmp/akshit/list |while read line
do 
ssh aa40608@$line 'bash' < /tmp/command >> /tmp/output
echo "****************** Done with Server $line ******************"
echo " "
done 


'''
How to use the script

Make a file name list : mention all the servers in the list. one server per line
Make a file name command : mention all the commands that needs to be executed on all servers.

'''