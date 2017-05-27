#!/bin/bash

# this program is design to rename files under specified directory
# we can rename to upper or lower.

function usage() {
    cat <<EOF
Usage:

$0 --upper <directory> or
$0 --lower <directory>

EOF
}

function batchmv() {
    opt=$1
    dir=$2
    
    arg=""
    if [ $opt == "--upper" ]; then
	arg="[a-z] [A-Z]"
    fi

    if [ $opt == "--lower" ]; then
	arg="[A-Z] [a-z]"
    fi

    files=`find $dir -maxdepth 1 -type f`
    for f in $files
    do
	dirn=`dirname $f`
	fn=`basename $f | cut -d'.' -f 1`
	suffix=`basename $f | cut -d'.' -f 2`
	new_fn=`echo $fn | tr $arg`
	if [ $new_fn == $fn ]; then
	    continue
	fi
	if [ X"$suffix" == X ]; then
	    mv $f ${dirn}/${new_fn}
	else
	    mv $f ${dirn}/${new_fn}.${suffix}
	fi
	if [ $? -ne 0 ]; then
	    echo "error occur, pelase check file permission of $f" >&2
	fi
    done
    echo "done"
}


if [ $# -ne 2 ]
then
    usage
    exit 1
fi

if [ $1 != "--upper" ] && [ $1 != "--lower" ]; then
    echo "option (--upper or --lower) should be specify" >&2
    exit 1
fi

stat $2  >/dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "directory does not exists" >&2
    exit 1
fi

batchmv $1 $2
