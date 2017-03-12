#!/bin/sh                                                                                                                           
while true                                                                                                                          
do                                                                                                                                  
ps_level=`cat /proc/wlan0/sdio_dbginfo | grep ps_level | awk '{print $2}'`                                                          
#echo "ps_level = $ps_level"                                                                                                        
if [ "${ps_level}" -eq "0" ];then                                                                                                   
dmesg >> /data/dmesg.log
exit                                                                                                           
fi
sleep 1                                                                                                                                 
done