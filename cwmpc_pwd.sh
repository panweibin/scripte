#!/bin/sh

cfg set cwmpc_acs_password ""
cfg setfactory cwmpc_acs_pre_password "$1"

cwmpc -v &
sleep 1
killall cwmpc
cfg get cwmpc_acs_password >> /data/keys.txt 2>/dev/null
