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

	"all")
		cur=`pwd`
		case $2 in
			"update")
				echo "update all svn repo from directory:$cur"
				cmd="svn up"
				;;
			"revision")
				cmd="svn info | grep Revision"
				echo "show all svn repo from directory:$cur"
				;;
		esac

		for d in `ls -d */`
		do
			if [ -d "$d.svn" ]; then
				echo "enter directory $d"
				echo "cd $d; $cmd; cd $cur" | bash
			fi
		done
		;;

	*)
	echo "Error command!"
	echo "    Useage: $0 [add|del|touch|revert|update-all]";
	;;

esac
