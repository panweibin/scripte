#!/bin/sh

telnet 192.168.1.1 6666
AT+CEVVMCMD=0XLLD0073TRICHEER
telnet 192.168.1.1 5504
at!unlock=tricheer123
at+system=telnetd -l /bin/sh
telnet 192.168.1.1
