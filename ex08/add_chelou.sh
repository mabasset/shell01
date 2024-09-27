#!/bin/sh

_escape_backslash() {
	echo ${1} | sed 's/\\/\\\\/g'
}

_str_to_nbr() {
	tr $( _escape_backslash "${1}" ) ${HEX_BASE}
}

_add() {
	echo "obase="${1}"; ibase="${2}";$( cat )" | bc
}

_nbr_to_str() {
	tr ${HEX_BASE} "$( _escape_backslash "${1}" )"
}

if [ -z $FT_NBR1 ] || [ -z $FT_NBR2 ];
then
	echo "FT_NBR1 and/or FT_NBR2 missing" >&2
	exit 1
fi

HEX_BASE='0123456789ABCDEF'
BASE1="'\\\"?!"
BASE2="mrdoc"
SUM_BASE="gtaio luSnemf"

echo $( echo "${FT_NBR1}" | _str_to_nbr "${BASE1}" ) + $( echo "${FT_NBR2}" | _str_to_nbr "${BASE2}" ) | _add ${#SUM_BASE} ${#BASE1} | _nbr_to_str "${SUM_BASE}"