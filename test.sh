#!/bin/sh
killall cwmpc
cfg setfactory cwmpc_acs_pre_password "$1"
cfg set cwmpc_acs_password ""
cwmpc &
sleep 1
killall cwmpc
key=`cfg get cwmpc_acs_password| head -n 1`
echo "$key" >> keys.txt


