#!/bin/sh

DNS_DEAMON=dnsmasq
DNS_CONFIG=dnsmasq.conf
TFTP_SERVER_ADDR=$1
DATA_PATH="/data"
TIME=`date +"%H_%M"`
DNS_LAN_PCAP_LOG="dns_lan_$TIME.pcap"
DNS_WAN_PCAP_LOG="dns_wan_$TIME.pcap"
DNS_DNSMASQ_LOG="dns_$TIME.log"
OTHER_INFO_LOG="dns_sys_info_$TIME.log"

LAN="br0"
WAN="rmnet_data0"

cd $DATA_PATH
tftp -g $TFTP_SERVER_ADDR -r $DNS_CONFIG
killall $DNS_DEAMON

cd /tmp
$DNS_DEAMON -C $DATA_PATH/$DNS_CONFIG &
tcpdump -i $LAN -w $DNS_LAN_PCAP_LOG &
tcpdump -i $WAN -w $DNS_WAN_PCAP_LOG &
sleep 1

ifconfig > $OTHER_INFO_LOG
echo "/tmp/resolv.dnsmasq" >> $OTHER_INFO_LOG
cat /tmp/resolv.dnsmasq >> $OTHER_INFO_LOG
sleep $2

killall tcpdump
mv dns.log $DNS_DNSMASQ_LOG
tar -cvf dns.tar $DNS_LAN_PCAP_LOG $DNS_WAN_PCAP_LOG $DNS_DNSMASQ_LOG $OTHER_INFO_LOG
tftp -p $TFTP_SERVER_ADDR -l dns.tar
rm dns.tar $DNS_LAN_PCAP_LOG $DNS_WAN_PCAP_LOG $DNS_DNSMASQ_LOG $OTHER_INFO_LOG