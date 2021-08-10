#!/bin/bash
#Author: pengjianqing@gmail.com, 2019/03/07
#Script used to backup files directorys
#Update your backup directorys at the end of the script
#backup_directory "/var/www/dokuwiki/wiki"
#backup_directory "/var/www/wordpress"

BACKUP_DEST_PATH="/mnt/backup_ssf"
BACKUP_DATE=`date +%y%m%d%H%M`
BACKUP_MAX_COUNT=8

# create the backup directory
BACKUP_TARGET_PATH=${BACKUP_DEST_PATH}/${BACKUP_DATE}

function clean_up {
    backup_count=`ls ${BACKUP_DEST_PATH} -t|grep -v "lost"|wc -l`
    remove_count=$((backup_count-BACKUP_MAX_COUNT))
    echo "${backup_count} backup files of max ${BACKUP_MAX_COUNT}, ${remove_count} to be removed"
    echo "All the backup files in ${BACKUP_DEST_PATH}:"
    ls ${BACKUP_DEST_PATH} -t|grep -v "lost"

    if [ ${remove_count} -gt 0 ];then
        echo "Clean up..."
        for i in `ls ${BACKUP_DEST_PATH} -t|grep -v "lost"|tail -n ${remove_count}`
        do
           echo "rm -rf ${BACKUP_DEST_PATH}/${i}"
           rm -rf ${BACKUP_DEST_PATH}/${i}
        done
        echo "Clean up...Done"
    fi
}

function backup_directory {
    echo "backup_directory..."
    mkdir -p ${BACKUP_TARGET_PATH}

    if [ "$#" = "1" ]; then
        BASE_NAME=`basename ${1}`
        BACKUP_TO=${BACKUP_TARGET_PATH}/${BASE_NAME}.tar.gz
        echo "backup ${1} to ${BACKUP_TO}"
        echo tar zcvPf ${BACKUP_TO}  ${1} >/dev/null
        tar zcvPf ${BACKUP_TO}  ${1} >/dev/null
        echo "backup_directory... DONE"
    else
        echo "missing backup directory?"
    fi
}

clean_up 
backup_directory "/var/www/dokuwiki/wiki"
backup_directory "/var/www/wordpress"

