#!/bin/sh
ifconfig 
cat /proc/wlan0/mib_all
 
#�_�C��ץ�����YӍ ץ���
echo "1th time"  
cat /proc/wlan0/sdio_dbginfo
cat /proc/wlan0/que_info  
cat /proc/wlan0/stats
cat /proc/wlan0/sta_dbginfo 
cat /proc/wlan0/sta_queinfo
iwpriv wlan0 reg_dump all  


echo "2th time"  
cat /proc/wlan0/sdio_dbginfo
cat /proc/wlan0/que_info  
cat /proc/wlan0/stats
cat /proc/wlan0/sta_dbginfo 
cat /proc/wlan0/sta_queinfo
iwpriv wlan0 reg_dump all  


echo "3th time"  
cat /proc/wlan0/sdio_dbginfo
cat /proc/wlan0/que_info  
cat /proc/wlan0/stats
cat /proc/wlan0/sta_dbginfo 
cat /proc/wlan0/sta_queinfo
iwpriv wlan0 reg_dump all  

echo "4th time"  
cat /proc/wlan0/sdio_dbginfo
cat /proc/wlan0/que_info  
cat /proc/wlan0/stats
cat /proc/wlan0/sta_dbginfo 
cat /proc/wlan0/sta_queinfo
iwpriv wlan0 reg_dump all  

echo "5th time"  
cat /proc/wlan0/sdio_dbginfo
cat /proc/wlan0/que_info  
cat /proc/wlan0/stats
cat /proc/wlan0/sta_dbginfo 
cat /proc/wlan0/sta_queinfo
iwpriv wlan0 reg_dump all  

dmesg
#�����@����z���Ƿ�����
iwpriv wlan0 set_mib ps_level=0