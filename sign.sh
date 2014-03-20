#!/bin/bash

count=0

puppet cert --list --all|egrep -q $1
[ $? -eq 0 ] && echo "Certificate for ${1} already signed" && exit 1

while true; do
	puppet cert --list|egrep -q $1
	if [ $? -eq 0 ]; then
		puppet cert --sign $1 
    echo "Certificate for ${1} signed successfuly"
		exit 0
	fi
  sleep 1
  let count++
	[ $count -gt 30 ] && echo "Timeout signing certificate for $1" && exit 1
done
