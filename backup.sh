#!/bin/bash
function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}


echo $HOSTNAME
echo Backing up
FOLDER=/mnt/gdrive/plexguide/backup
DOCKERS="sonarr radarr nzbget nzbhydra traktarr radarr4k sonarr4k sabnzbd nabarr organizr prowlarr mediarr Plex-Meta-Manager"
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
#docker restart $(docker ps -q)
sudo docker restart $(docker ps -aq --format '{{.Names}}' | sed '/^$/d' | grep -E 'arr')
start:
echo after start
for VAR in $DOCKERS
do
        if [ "$( docker container inspect -f '{{.State.Running}}' $VAR )" == "true" ];
        then
        echo $VAR up
        else
        echo $VAR down
        docker start $VAR
        jumpto start
        fi
done

echo finished at `date`
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo pushing out to Healthcheck.io
curl -m 10 --retry 5 https://hc-ping.com/13dea367-46f0-4d24-b6c0-3cc60b476186
curl https://cronitor.link/p/c906798535ac4c0488c7412f85864809/FRwCKy?state=run
