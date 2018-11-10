#!/bin/sh

if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

#### Functions

get_process_mem()
{
	PID=$1

	if [ -f /proc/$PID/smaps ];
	then
		# Get Process Name 
		Name=`ps -p $PID -o comm=`

		# Get Rss & Pss & Uss Size
		Rss=`cat /proc/$PID/smaps | grep -e "^Rss:" | awk 'BEGIN {sum=0} { sum+=$2 } END { print sum }'`
		if [ $Rss -ne 0 ]; then
			Pss=`cat /proc/$PID/smaps | grep -e "^Pss:" | awk 'BEGIN {sum=0} { sum+=$2 } END { print sum }'`
			Uss=`cat /proc/$PID/smaps | grep -e "^Private" | awk 'BEGIN {sum=0} { sum+=$2 } END { print sum }'`
			printf "%4d %15s %10d %10d %10d\n" ${PID} "${Name}" ${Uss} ${Pss} ${Rss}
		fi
	fi

}

#### Main Process

printf "%4s %15s %10s %10s %10s\n" "PID" "Name" "Uss" "Pss" "Rss"

if [ $# -eq 0 ]
then
	pids=`ls /proc | grep -e [0-9] | grep -v [A-Za-z] `
	for i in $pids
	do
		if [ $$ -ne $i ]; then
			get_process_mem $i
		fi
	done
else
	get_process_mem $1
fi

