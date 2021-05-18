#!/bin/bash
echo hello
TRAK="docker exec -i traktarr /traktarr/traktarr.py"
LIST="trending anticipated popular played"
M=50
S=5

for x in $LIST
do
        echo ""
        echo $x
        if [ $x = trending ] || [ $x = anticipated ]
        then
                echo $x is trending
                $TRAK movies -t $x
                echo sleep for 2s
                sleep 30s
        else
                $TRAK movies -t $x -l $M
                echo sleep for 2S
                sleep 30s
        fi
done


for x in $LIST
do
        echo ""
        echo $x
        if [ $x = anticipated ]
        then
                echo $x is trending
                $TRAK shows -t $x
                echo sleep for 2s
                sleep 30s
        else
                $TRAK shows -t $x -l $S
                echo sleep for 2S
                sleep 30s
        fi
done
