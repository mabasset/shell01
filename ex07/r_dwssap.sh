#!/bin/sh

if [ -z $FT_LINE1 ] || [ -z $FT_LINE2 ];
then
	echo "FT_LINE1 and/or FT_LINE2 missing" >&2
	exit 1
fi

cat /etc/passwd | sed '/^#/d' | grep -v '^$' | rev | awk -F ':' 'NR % 2 == 0 { print $NF ", " }' | sort -r | sed -n "$FT_LINE1,$FT_LINE2 p" | tr -d '\n' | sed 's/, $/./'