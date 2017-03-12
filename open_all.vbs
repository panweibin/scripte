'**********************************************************************
' Copyright (C) 2012-2014 tricheer <panweibin@tricheer.com>
' Created by: panweibin@tricheer.com
' 自动打开router 平台的telnet脚本
' 2016-08-10 初始化版本，保证基本功能功能Ok；
' 2016-08-20 引入第一次优化；保证5504可以正常退出；
'**********************************************************************

'根据网卡信息获取默认网关，假设网关是192.168.x.1
dim targetIp 
GetGatewayIP()
targetIp = "192.168.1.1"
If targetIp <> "" then
'由于服务默认是关闭的，首先打开telnetd服务
OpenTelnet5504()
OpenTelnetd()
'打开telnetd服务后，再建立telnet窗口并默认打开telnet；
OpenTelnet()
'DoWlanSDIO3()
'OnSendCommandGetWiFiChannel()
Else
'获取不到想要的IP地址，提示错误；检查是否插入USB线或者切口
msgbox ("Please Check USB cable is plugged in or Switch to USB Adapter")
End If

Function OpenTelnet5504()
	set oShell = CreateObject("WScript.Shell")
	oShell.run"cmd.exe"
	WScript.Sleep 200
	oShell.SendKeys"telnet "+targetIp+" 6666"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500	
	oShell.SendKeys"AT{+}CEVVMCMD=0XLLD0073TRICHEER"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500	
	oShell.SendKeys"AT{+}CEVVMCMD=0XLLD0073JMR1040"
	oShell.SendKeys("{Enter}")	
	WScript.Sleep 500
	oShell.SendKeys"%{f4}"
	oShell.SendKeys"{Enter}"
End Function

Function OpenTelnetd()
	set oShell = CreateObject("WScript.Shell")
	oShell.run"cmd.exe"
	WScript.Sleep 200
	oShell.SendKeys"telnet "+targetIp+" 5504"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500	
	oShell.SendKeys"at!unlock=10"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 300
	oShell.SendKeys"at!unlock=tricheer123"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 300
	oShell.SendKeys("at{+}system=telnetd -l /bin/sh")
	oShell.SendKeys("{Enter}")
	WScript.Sleep 300
	'oShell.SendKeys("at{+}usbmode=7")
	'oShell.SendKeys("{Enter}")
	'WScript.Sleep 300
	oShell.SendKeys"%{f4}"
	oShell.SendKeys"{Enter}"
	'WScript.Sleep 800
End Function

Function OnSendCommandGetWiFiChannel()
	set oShell = CreateObject("WScript.Shell")
	oShell.run"cmd.exe"
	WScript.Sleep 200
	oShell.SendKeys"telnet "+targetIp
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500
	oShell.SendKeys"iwpriv wlan0 getchannel"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500
	oShell.SendKeys"iwpriv wlan1 getchannel"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500
	oShell.SendKeys"sys_reboot"
	oShell.SendKeys("{Enter}")
End Function

Function OpenTelnet()
	set oShell = CreateObject("WScript.Shell")
	oShell.run"cmd.exe"
	WScript.Sleep 200
	oShell.SendKeys"telnet "+targetIp
	oShell.SendKeys("{Enter}")
	'WScript.Sleep 500
	'oShell.SendKeys"iwpriv wlan0 efuse_set SD=3"
	'oShell.SendKeys("{Enter}")
	'WScript.Sleep 500
	'oShell.SendKeys"iwpriv wlan0 efuse_sync"
	'oShell.SendKeys("{Enter}")
	'WScript.Sleep 500	
End Function

Function DoWlanSDIO3()
	set oShell = CreateObject("WScript.Shell")
	oShell.run"cmd.exe"
	WScript.Sleep 200
	oShell.SendKeys"telnet "+targetIp
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500
	oShell.SendKeys"iwpriv wlan0 efuse_set SD=3"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500
	oShell.SendKeys"iwpriv wlan0 efuse_sync"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500	
End Function

Public Function GetGatewayIP()
   ComputerName="."
    Dim objWMIService,colItems,objItem,objAddress
    Set objWMIService = GetObject("winmgmts:\\" & ComputerName & "\root\cimv2")
    Set colItems = objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
    For Each objItem in colItems
        For Each objAddress in objItem.DefaultIPGateway
            If objAddress <> "" then
				'wscript.Echo objAddress
				'If StrComp(objAddress, "192.168.0.1",1) = 0 Then
					'wscript.Echo objAddress
				'	Exit Function
				'ElseIf StrComp(objAddress, "192.168.1.1",1) = 0 Then
					'wscript.Echo objAddress
				'	Exit Function
				If InStr(objAddress, "192.168") <> 0 Then
					'wscript.Echo objAddress
					targetIp = objAddress
					Exit Function
				End If
            End If
        Next
    Next
End Function

