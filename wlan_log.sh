#!/bin/sh
ifconfig 
cat /proc/wlan0/mib_all
 
#開機後抓下面資訊 抓五次
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
#配置這個後檢查是否正常
iwpriv wlan0 set_mib ps_level=0