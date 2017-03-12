#!/bin/sh
#@example : sfe_dump 
sfe_dump()
{
    [  -z "/dev/sfe_ipv4" ] && return
	dev_num=$(cat /sys/sfe_ipv4/debug_dev) 
	mknod /dev/sfe_ipv4 c $dev_num 0
    cat /dev/sfe_ipv4
}

sfe_dump