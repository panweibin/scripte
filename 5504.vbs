'**********************************************************************
' Copyright (C) 2012-2014 tricheer <panweibin@tricheer.com>
' Created by: panweibin@tricheer.com
' 2016-08-10
' 自动打开router 平台的telnet脚本
'**********************************************************************

'根据网卡信息获取默认网关，假设网关是192.168.x.1
dim targetIp 
GetGatewayIP()

If targetIp <> "" then
'由于服务默认是关闭的，首先打开telnetd服务
OpenTelnetd()
'打开telnetd服务后，再建立telnet窗口并默认打开telnet；
'OpenTelnet()
Else
'获取不到想要的IP地址，提示错误；检查是否插入USB线或者切口
msgbox ("Please Check USB cable is plugged in or Switch to USB Adapter")
End If

Function OpenTelnetd()
	set oShell = CreateObject("WScript.Shell")
	oShell.run"cmd.exe"
	WScript.Sleep 300
	oShell.SendKeys"telnet "+targetIp+" 5504"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 500
	oShell.SendKeys"at!unlock=10"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 300
End Function

Function OpenTelnet()
	set oShell = CreateObject("WScript.Shell")
	oShell.run"cmd.exe"
	WScript.Sleep 300
	oShell.SendKeys"telnet "+targetIp
	oShell.SendKeys("{Enter}")
	oShell.SendKeys"ls -al /lib/modules/3.18.20/"
	oShell.SendKeys("{Enter}")
End Function

Public Function GetGatewayIP()
   ComputerName="."
    Dim objWMIService,colItems,objItem,objAddress
    Set objWMIService = GetObject("winmgmts:\\" & ComputerName & "\root\cimv2")
    Set colItems = objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
    For Each objItem in colItems
        For Each objAddress in objItem.DefaultIPGateway
            If objAddress <> "" then
				If InStr(objAddress, "192.168") <> 0 Then
					targetIp = objAddress
					Exit Function
				End If
            End If
        Next
    Next
End Function

