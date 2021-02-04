#!/bin/bash
echo Backing up
FOLDER=/mnt/gdrive/plexguide/backup
DOCKERS=`ls /opt/appdata/`
echo $FOLDER
DATES=`date +%Y-%m-%d_%H.%M.%S`
echo $DATES
rclone --config=/opt/appdata/uploader/rclone.conf mkdir gdrive:/plexguide/backup/archive/$DATES -v --stats 2s
echo ARCHIVING OLD BACKUPS
rclone --config=/opt/appdata/uploader/rclone.conf -v --stats 5s copy gdrive:/plexguide/backup/gce-master/ gdrive:/plexguide/backup/archive/$DATES/

for VAR in $DOCKERS
do
        sleep 5s
        echo $VAR
        echo $VAR >/tmp/program_var && bash /opt/pgvault/pgcron

done
