#!/bin/sh
# svn commit log monitor, add script to cron every day job
#

SVN_REPOS="http://svn.demo.net/svn/repo1
            http://svn.demo.net/svn/repo2
            http://svn.demo.net/svn/repo3"


if [ $# -eq 1 ] && [ $1 = "-f" ]; then
	TO_FILE=1
else
	TO_FILE=0
fi

START=`date --date yesterday "+%Y%m%d"`
END=`date +%Y%m%d`
NOW=`date +%Y%m%d%H%M%S`

LOG_FILE="./svn-log-$NOW.txt"

echo "version from $START to $END @$NOW"

for REPO in $SVN_REPOS; do
	echo "Read $REPO"

	REPO_INFO=`svn log $REPO -r {$START}:{$END}`
	IS_INFO=`echo $REPO_INFO | grep "|" | wc -l`

	if [ $IS_INFO -gt 0 ]; then
		if [ $TO_FILE -eq 1 ]; then
			echo "$REPO" >> $LOG_FILE
			echo "$REPO_INFO" >> $LOG_FILE
		else
			echo "$REPO_INFO"
		fi
	fi
done
