'**********************************************************************
' Copyright (C) 2012-2014 tricheer <panweibin@tricheer.com>
' Created by: panweibin@tricheer.com
' 2016-08-10
' 自动打开router 平台的telnet脚本,并检查是否可以ping通
'**********************************************************************

'根据网卡信息获取默认网关，假设网关是192.168.x.1
dim targetIp 
GetGatewayIP()

If targetIp <> "" then
'由于服务默认是关闭的，首先打开telnetd服务
OpenTelnetd()
Else
'获取不到想要的IP地址，提示错误；检查是否插入USB线或者切口
msgbox ("Please Check USB cable is plugged in or Switch to USB Adapter")
End If

Function DiagPing()
	set oShell = CreateObject("WScript.Shell")
	Set objExec = oShell.Exec("ping -n 2 -w 500 " & targetIp)
	strPingResults = LCase(objExec.StdOut.ReadAll)
	msgbox ("Telnet is opened\n" &"The ping results is: " & strPingResults)
End Function

'打开telnetd服务
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
	
	oShell.SendKeys"at!unlock=tricheer123"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 300
	
	oShell.SendKeys"at!reboot"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 10000
	oShell.SendKeys"exit"
	oShell.SendKeys("{Enter}")
	WScript.Sleep 300
End Function

'从系统服务中获取网络信息，包括但不限于之与网关IP，DNS服务器地址等
Public Function GetGatewayIP()
   ComputerName="."
    Dim objWMIService,colItems,objItem,objAddress
    Set objWMIService = GetObject("winmgmts:\\" & ComputerName & "\root\cimv2")
    Set colItems = objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
    For Each objItem in colItems
        For Each objAddress in objItem.DefaultIPGateway
            If objAddress <> "" then
				If InStr(objAddress, "192.168") <> 0 Then
					'wscript.Echo objAddress
					targetIp = objAddress
					Exit Function
				End If
            End If
        Next
    Next
End Function

