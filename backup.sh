#!/bin/bash
echo $HOSTNAME
echo Backing up
FOLDER=/mnt/gdrive/plexguide/backup
DOCKERS=`ls /opt/appdata/`
echo $FOLDER
DATES=`date +%Y-%m-%d_%H.%M`
echo $DATES
rclone --config=/opt/appdata/uploader/rclone.conf mkdir gdrive:/plexguide/backup/archive/$HOSTNAME/$DATES -v --stats 2s
echo ARCHIVING OLD BACKUPS
rclone --config=/opt/appdata/uploader/rclone.conf -v --stats 5s copy gdrive:/plexguide/backup/$HOSTNAME/ gdrive:/plexguide/backup/archive/$HOSTNAME/$DATES/

for VAR in $DOCKERS
do
        echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        echo "sleep for 5 seconds"
        echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        sleep 5s
        echo $VAR
        echo $VAR >/tmp/program_var && bash /opt/pgvault/pgcron

done
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo Testing complete $date
echo restarting all dockers
docker restart $(docker ps -q)
echo finished at $DATE
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
