#!/bin/sh

#set -x
ancmode="an anc "
band_width="0 1 2 3 "
channel_lists="36  40  44  48  52  56  60  64  100  104  108  112  116  120  124  128  132  136  140 "
for mode in $ancmode
	do
	cfg set wlan_ap0_80211mode $mode 1>/dev/null
	for i in $band_width
		do
		cfg set wlan_ap0_band_width $i 1>/dev/null
		for j in $channel_lists
		do
			#echo "i is $i and j is $j"
			echo "{{{{{{{{{{{{{{{{{{{{{{start test 80211mode:$mode, bandwidth:$i, channel:$j"
			date 
			cfg set wlan_ap0_channel $j 1>/dev/null
			wlan_test restart_app ap0 1>2 2>/dev/null
			cat /tmp/hostapd.wlan0.conf | grep ht -i
			
			sleep 2
			realchannel=`iwpriv wlan0 getchannel | awk -F: '{print $2}'`
			if [ $realchannel != $j ]
			then
				echo "!!!WARNING HERE, realchannel is $realchannel pls double check it"
			fi
			
			hostapd_pid=`ps | grep [h]ostapd | awk '{print $1}'`
			if [ -z "$hostapd_pid" ] 
			then
				echo "!!!ERRORING HERE, hostapd start fail and pls double check it"
			fi
			echo "}}}}}}}}}}}}}}}}}}}}}}}}end test band with $i and channel $j"
			echo ""
			echo ""
		done
	done
done
