#!/bin/bash
#set -x 

function main()
{
    if [[ -z $(ps -ef|grep -i hawk|grep -v Disable|grep -i $(DOMAIN_NAME)|grep -v grep) ]]; then
    echo "`date '+%m:%d:%y  %H%M%S'`  - [ERROR]  - No Hawk is running...Exiting"
    exit 0
    else
        if [[ $action == "enable"]]; then
            enable
        else
            disable
        fi
    fi
}

#enable hawk 
function enable(){
    local HRB_COUNT=0
    HAWK_PID=$(ps -ef|grep -i hawkagent|grep -v "grep"|grep -i $(DOMAIN_NAME)|awk '{print $2}')
    HAWK_PATH=$(pwdx ${HAWK_PID}|awk '{print $2}')
    cd ${HAWK_PATH}
    if [[ -f "autoconfig_bkp_${DOMAIN_NAME}.tar.gz" ]]; then 
        tar -xf autoconfig_bkp_${DOMAIN_NAME}.tar.gz
        sleep 10
        HRB_COUNT=$(ls -lrt ${HAWK_PATH}/autoconfig/*.hrb|wc -l)
        echo -e "`date '+%m:%d:%y  %H%M%S'`  - [INFO] - Hawk Enabled for ${DOMAIN_NAME}. HRB's Restored : ${HRB_COUNT}"
        echo -e "-----------------------------------------------------------------------"
        restartHawk
        echo -e "============== Listing of HRB's from Autoconfig =============="
        ls -lrt ${HAWK_PATH}/autoconfig
        echo -e "Hawk HRB has been enabled successfully. Removing the tar file."
        rm autoconfig_bkp_${DOMAIN_NAME}.tar.gz
    else
        echo -e "No Backup File Available.. Exiting.."
        exit 1
    fi
}

#disabling hawk
function disable(){
    local HRB_COUNT=0
    HAWK_PID=$(ps -ef|grep -i hawkagent|grep -v "grep"|grep -i $(DOMAIN_NAME)|awk '{print $2}')
    HAWK_PATH=$(pwdx ${HAWK_PID}|awk '{print $2}')
    cd ${HAWK_PATH}
    HRB_COUNT=$(ls -lrt ${HAWK_PATH}/autoconfig/*.hrb|wc -l)
    tar -zcf autoconfig_bkp_${DOMAIN_NAME}.tar.gz autoconfig
    sleep 10
    rm -rf autoconfig
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [INFO] - Hawk Disabled for ${DOMAIN_NAME}. HRB's Backed Up : ${HRB_COUNT}"
    echo -e "-----------------------------------------------------------------------"
    restartHawk
    echo -e "============== Listing of HRB's from Autoconfig =============="
    ls -lrt ${HAWK_PATH}/autoconfig
}

#hawk restart
function restartHawk(){
    echo -e "`date '+%m:%d:%y  %H%M%S'`  - [INFO] - Restarting Hawk for ${DOMAIN_NAME}"
    cd ${HAWK_PATH}
    echo -e "Current working Directory is : `pwd`"
    TIBHAWKHMA_PID=$(ps -ef|grep -i tibhawkhma|grep -v "#"|grep -i ${DOMAIN_NAME}|awk '{print $2}')
    kill -9 ${HAWK_PID} ${TIBHAWKHMA_PID}
    nohup ./hawkagent_${DOMAIN_NAME} & 
    echo -e " "
    sleep 30
}

#check if the script has input 
while [ -n "$1" ]; do 
    case $1 in
        -domain | -d ) DOMAIN_NAME=$2
        shift
        ;;
        -disable ) action=disable
        main
        exit 0 
        ;;
        -enable ) action=enable
        main
        exit 0
        ;;
        * ) echo -e "Invalid Option passed : $1"
        exit 1 
    esac
    shift
done


'''
How to use the script

/bin/bash ./HawkControl.sh -domain <DOMAIN_NAME> -<ACTION>

/bin/bash ./HawkControl.sh -domain MyDomain -disable
/bin/bash ./HawkControl.sh -domain MyDomain -enable
'''