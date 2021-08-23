#!/bin/bash
s="echo 'sleep2s' && sleep 2s"
echo from github
echo "apt-get update"
apt-get update
echo "sleep 2s"
sleep 2s
$s
