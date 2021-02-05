#!/bin/bash

trap "exit" INT TERM
trap "kill 0" EXIT

adb kill-server

adb.exe -a -P 5038 nodaemon server &
socat TCP-LISTEN:5037,reuseaddr,fork TCP:$(cat /etc/resolv.conf | tail -n1 | cut -d " " -f 2):5038 &

for job in `jobs -p`
do
	wait $job
done
