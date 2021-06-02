#!/bin/bash
echo hello
TRAK="docker exec -i traktarr /traktarr/traktarr.py"
LIST="trending anticipated popular played"
M=50
S=5
sleeptime=60s



for x in $LIST
do
        echo ""
        echo $x
        if [ $x = trending ] || [ $x = anticipated ]
        then
                echo $x is trending
                $TRAK movies -t $x
                echo sleep for $sleeptime
                sleep $sleeptime
        else
                $TRAK movies -t $x -l $M
                echo sleep for $sleeptime
                sleep $sleeptime
        fi
done


for x in $LIST
do
        echo ""
        echo $x
        if [ $x = anticipated ]
        then
                echo $x is anticipated
                $TRAK shows -t $x
                echo sleep for $sleeptime
                sleep $sleeptime
        else
                $TRAK shows -t $x -l $S
                echo sleep for $sleeptime
                sleep $sleeptime
        fi
done
