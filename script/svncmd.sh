#!/bin/sh


case $1 in

	"add")
		# add all new files
		echo "add all new file to repo"
		svn st | grep ^? | awk '{print "svn add " $2}' | bash
	;;

	"del")
		# remove all miss files
		echo "remove all miss files"
		svn st | grep ^! | awk '{print "svn rm " $2}' | bash
	;;

	"touch")
		# touch all modify file 
		echo "touch all modify file"
		svn st | grep ^M | awk '{print "touch " $2}' | bash
	;;

	"revert")
		# touch all modify file 
		echo "revert all modify file"
		svn st | grep ^M | awk '{print "svn revert " $2}' | bash
		;;

	*)
	echo "Error command!"
	echo "    Useage: svn.tools [add|del|touch|revert]";
	;;

esac

