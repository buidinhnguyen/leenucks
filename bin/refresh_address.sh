#!/bin/sh
#
# License: GPLv2 or later
# by tomka (http://dev.gentoo.org/~tomka/mail.html)

acc1=~/Mail/GMail/all_mail/cur
acc2=~/Mail/personal/all_mail/cur

parsemail () {
	cat ${1} | lbdb-fetchaddr
}

parsemaildir () {
	for mailfile in $( find ${1} -type f -mtime -5 ) ; do
	parsemail ${mailfile}
done
}

# The IFS variable saves the file name separator 
# which we will temporarily set to \n so that the
# spaces in Gmail folders will work

for i in "${acc1}" "${acc2}" ; do 
	o=${IFS}
	IFS=$(echo -en "\n\b")
	parsemaildir "${i}"
	IFS=o
done

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:
