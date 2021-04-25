#!/bin/bash
if grep -Fxq "complete_dir = /mnt/unionfs/Downloads/complete" /opt/appdata/sabnzbd/sabnzbd.ini
then

        echo $(date) - sabnzbd ok >> /root/download_check.log
else
        echo $(date) - sabnzbd NOT ok >> /root/download_check.log
        docker stop sabnzbd
        cp /opt/appdata/sabnzbd/sabnzbd.ini_CORRECT /opt/appdata/sabnzbd/sabnzbd.ini
        docker start sabnzbd
fi
if grep -Fxq "DestDir=/mnt/unionfs/Downloads/complete" /opt/appdata/nzbget/nzbget.conf
then

        echo $(date) - nzbget ok >> /root/download_check.log
else
        echo $(date) - nzbget NOT ok >> /root/download_check.log
        docker stop nzbget
        cp /opt/appdata/nzbget/nzbget.conf_CORRECT /opt/appdata/nzbget/nzbget.conf
        docker start nzbget
fi

