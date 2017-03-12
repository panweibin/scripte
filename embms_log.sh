#!/bin/sh

#common settings
LAN="br0"
WAN="rmnet_data0"

TFTP_SERVER_ADDR=$1
DATA_PATH="/data"
TIME=`date +"%H_%M"`
LAN_PCAP_LOG="lan_$TIME.pcap"
WAN_PCAP_LOG="wan_$TIME.pcap"

#custom need refill
RMT_FILES="embms_v1.tgz"
DEAMON_NAME="at_translator"
LOG_FILE="embms_$TIME.log"

if [ "1" == "$3" ]; then
	cfg set nm_custom_url "jiofi.local.html>jiomifi.local.html>embms.jio.local"
	lc_nm dnsmasq restart
fi
   
cd $DATA_PATH
tftp -g $TFTP_SERVER_ADDR -r $RMT_FILES
tar -xzvf $RMT_FILES
cd embms
stop_debug
start_debug -o 0 -f $DATA_PATH/$LOG_FILE
tcpdump -i $LAN -w $LAN_PCAP_LOG &
tcpdump -i $WAN -w $WAN_PCAP_LOG &

chmod 777 $DEAMON_NAME
./$DEAMON_NAME &

sleep $2

killall tcpdump
tar -cvf log.tar $LAN_PCAP_LOG $WAN_PCAP_LOG $LOG_FILE
tftp -p $TFTP_SERVER_ADDR -l log.tar
rm dns.tar $LAN_PCAP_LOG $WAN_PCAP_LOG $LOG_FILE