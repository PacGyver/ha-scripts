#!/bin/bash
OUTPUT="/var/state/tvpower"
SLEEP=5
DEVICE=0
(while true ; do sleep $SLEEP ; echo "pow $DEVICE" ; done) |cec-client -d 8 -p 1 -b 5 -t p | grep power  --line-buffered | while read x ; do	
	STATE=`echo $x | awk '{split($0,a,":");print a[2]}' | sed 's/ //'`
	if [ $STATE == "on" -o $STATE == "standby" ]
	then
		echo $STATE | tee $OUTPUT
	fi
done
