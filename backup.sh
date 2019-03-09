#!/bin/bash
#Author: pengjianqing@gmail.com, 2019/03/07
#Script used to backup files directorys
#Update your backup directorys at the end of the script
#backup_directory "/var/www/dokuwiki/wiki"
#backup_directory "/var/www/wordpress"

BACKUP_DEST_PATH="/mnt/backup"
BACKUP_DATE=`date +%y%m%d%H%M`

# create the backup directory
BACKUP_TARGET_PATH=${BACKUP_DEST_PATH}/${BACKUP_DATE}
mkdir -p ${BACKUP_TARGET_PATH}

function backup_directory {
    echo "backup_directory..."

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

backup_directory "/var/www/dokuwiki/wiki"
backup_directory "/var/www/wordpress"

