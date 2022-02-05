#!/bin/bash
if [ "$1" = "clean" ]; then
    echo "deleting previous backups..."
    for FILE in $(/usr/local/bin/rclone lsf onedrive:/linux-backup); do
	echo "deleting $FILE"
	/usr/local/bin/rclone delete onedrive:/linux-backup/$FILE
    done
else
    	echo "starting backup..."
BACKUPFILE=$(date +%m%d%y).tar
echo "compressing the home folder..."
tar -cf ~/$BACKUPFILE ~/
gzip ~/$BACKUPFILE
echo "copying the backup to One Drive..."
/usr/local/bin/rclone copy ~/$BACKUPFILE.gz onedrive:/linux-backup
if /usr/local/bin/rclone ls onedrive:/linux-backup/$BACKUPFILE.gz; then
    echo "The backup was successful."
    rm ~/$BACKUPFILE.gz
    else
	echo "The backup was not successful."
fi
fi
