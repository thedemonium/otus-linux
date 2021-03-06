#!/usr/bin/env bash

pids=`ls /proc/ | grep [0-9] | sort -n`

for pid in $pids
  do
  	DIRECTORY="/proc/$pid"
    if [ -d "$DIRECTORY" ]; then
    echo ""
	pidproc=`cat /proc/$pid/status | grep -w "Pid:" | awk '{print $2}'`
	ttyproc=`readlink /proc/$pid/fd/0`
	statproc=`cat /proc/$pid/status | grep -w "State:" | awk '{print $2}'`
	timeproc=`awk '{print $14+$15}' /proc/$pid/stat`
	#cmdproc=`cat /proc/$pid/cmdline`
	cmdproc=$(tr -d '\0' </proc/$pid/cmdline)
	printf "$pidproc | $ttyproc | $statproc | $timeproc | $cmdproc "
    fi
  done



