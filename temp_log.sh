#!/bin/sh
TEMP_PATH="/sys/devices/virtual/thermal/thermal_zone"
while
true
do
echo ""
echo "get temp start"
date
	for i in 0 1 2 3 4 5 6 7
	do
		echo "echo i $i"
		type=`cat $TEMP_PATH$i/type`
		temp=`cat $TEMP_PATH$i/temp`
		echo "type:$type, temp:$temp"
	done
echo "sleep 5 secondes and record temp again"
echo "get temp end"
sleep 5

done