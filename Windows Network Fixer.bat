@echo off
title Windows Network Fixer
setlocal
echo Program Name: Windows Network Fixer
echo Version: 1.7.1
echo Developer: @YonatanReuvenIsraeli
echo Website: https://www.yonatanreuvenisraeli.dev
echo License: GNU General Public License v3.0
net session > nul 2>&1
if not "%errorlevel%"=="0" goto "NotAdministrator"
net user > nul 2>&1
if not "%errorlevel%"=="0" goto "InWindowsRecoveryEnvironment"
goto "Start"

:"NotAdministrator"
echo.
echo Please run this batch file as an administrator. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"InWindowsRecoveryEnvironment"
echo.
echo Please run this batch file from within Windows. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"Start"
echo.
echo Network View:
echo [1] View current network configuration.
echo [2] View DNS servers.
echo [3] View DNS cache.
echo [4] View ARP cache.
echo [5] View routing table.
echo [6] View Hosts file.
echo [7] View Windows Defender Firewall with Advanced Security.
echo [8] View Destination Cache.
echo [9] View current WinHTTP proxy status.
echo.
echo Network Repairs:
echo [10] Release and renew IP address(es).
echo [11] Clear DNS cache.
echo [12] Reset Winsock catalog.
echo [13] Reset TCP/IP stack.
echo [14] Clear ARP cache.
echo [15] Clear routing table.
echo [16] Reset Hosts file to default.
echo [17] Set WinHTTP proxy to default.
echo.
echo Firewall Repairs:
echo [18] Set Windows Defender Firewall rules to defualt.
echo.
echo [19] Close
echo.
set Repair=
set /p Repair="What do you want to do? (1-19) "
if /i "%Repair%"=="1" goto "1"
if /i "%Repair%"=="2" goto "2"
if /i "%Repair%"=="3" goto "3"
if /i "%Repair%"=="4" goto "4"
if /i "%Repair%"=="5" goto "5"
if /i "%Repair%"=="6" goto "6"
if /i "%Repair%"=="7" goto "7"
if /i "%Repair%"=="8" goto "8"
if /i "%Repair%"=="9" goto "9"
if /i "%Repair%"=="10" goto "10"
if /i "%Repair%"=="11" goto "11"
if /i "%Repair%"=="12" goto "12"
if /i "%Repair%"=="13" goto "regini"
if /i "%Repair%"=="14" goto "14"
if /i "%Repair%"=="15" goto "15"
if /i "%Repair%"=="16" goto "16"
if /i "%Repair%"=="17" goto "17"
if /i "%Repair%"=="18" goto "18"
if /i "%Repair%"=="19" goto "Close"
echo Invalid syntax!
goto "Start"

:"1"
ipconfig /all
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"2"
netsh int ip show dnsservers
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"3"
ipconfig /displaydns
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"4"
arp /a
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"5"
route print
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"6"
"%windir%\notepad.exe" "%windir%\System32\drivers\etc\hosts"
if not "%errorlevel%"=="0" goto "Error"
goto "Start"


:"7"
"%windir%\System32\wf.msc"
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"8"
netsh int ip show destinationcache
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"9"
netsh winhttp show proxy
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"10"
echo.
echo Releasing and renewing IP address(es).
ipconfig /release > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
ipconfig /renew > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo IP address(es) released and renewed.
goto "Start"

:"11"
echo.
echo Clear DNS cache.
ipconfig /flushdns > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo DNS cache cleared.
goto "Start"

:"12"
echo.
echo Reseting Winsock catalog.
netsh winsock reset > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo Winsock catalog reset.
goto "Start"

:"regini"
set regini=
goto "13"

:"13"
if exist "%cd%\regini.txt" goto "reginiExist"
echo.
echo Reseting TCP/IP stack.
echo HKLM\SYSTEM\CurrentControlSet\Control\Nsi\{eb004a00-9b1a-11d4-9123-0050047759bc}\26 [1] > "%cd%\regini.txt"
regini "%cd%\regini.txt" > nul 2>&1
if not "%errorlevel%"=="0" goto "reginiError"
del "%cd%\regini.txt" /f /q
netsh int ip reset > nul 2>&1
if /i "%regini%"=="True" goto "reginiDone"
goto "Restart"

:"reginiExist"
set regini=True
echo.
echo Please temporary rename to something else or temporary move to another location "%cd%\regini.txt" in order for this batch file to proceed. "%cd%\regini.txt" is not a system file. Press any key to continue when "%cd%\regini.txt" is renamed to something else or moved to another location. This batch file will let you know when you can rename it back to its original name or move it back to its original location.
pause > nul 2>&1
goto "13"

:"reginiError"
del "%cd%\regini.txt" /f /q
echo There has been an error! You can try again.
goto "Start"

:"reginiDone"
echo.
echo You can now rename or move back the file back to "%cd%\regini.txt"
goto "Restart"

:"Restart"
endlocal
echo Restart needed to finish reseting TCP/IP stack. Press any key to restart this PC.
pause > nul 2>&1
shutdown /r /t 00

:"14"
echo.
echo Clearing APR cache.
netsh interface IP delete arpcache > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo ARP cache cleared.
goto "Start"

:"15"
echo.
echo Clearing routing table.
route -f > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo Routing table cleared.
goto "Start"

:"16"
echo.
echo Reseting Host file.
(echo # Copyright ^(c^) 1993-2009 Microsoft Corp.) > "%windir%\System32\drivers\etc\hosts"
(echo #) >> "%windir%\System32\drivers\etc\hosts"
(echo # This is a sample HOSTS file used by Microsoft TCP/IP for Windows.) >> "%windir%\System32\drivers\etc\hosts"
(echo #) >> "%windir%\System32\drivers\etc\hosts"
(echo # This file contains the mappings of IP addresses to host names. Each) >> "%windir%\System32\drivers\etc\hosts"
(echo # entry should be kept on an individual line. The IP address should) >> "%windir%\System32\drivers\etc\hosts"
(echo # be placed in the first column followed by the corresponding host name.) >> "%windir%\System32\drivers\etc\hosts"
(echo # The IP address and the host name should be separated by at least one) >> "%windir%\System32\drivers\etc\hosts"
(echo # space.) >> "%windir%\System32\drivers\etc\hosts"
(echo #) >> "%windir%\System32\drivers\etc\hosts"
(echo # Additionally, comments ^(such as these^) may be inserted on individual) >> "%windir%\System32\drivers\etc\hosts"
(echo # lines or following the machine name denoted by a '#' symbol.) >> "%windir%\System32\drivers\etc\hosts"
(echo #) >> "%windir%\System32\drivers\etc\hosts"
(echo # For example:) >> "%windir%\System32\drivers\etc\hosts"
(echo #) >> "%windir%\System32\drivers\etc\hosts"
(echo #      102.54.94.97     rhino.acme.com          # source server) >> "%windir%\System32\drivers\etc\hosts"
(echo #       38.25.63.10     x.acme.com              # x client host) >> "%windir%\System32\drivers\etc\hosts"
(echo.) >> "%windir%\System32\drivers\etc\hosts"
(echo # localhost name resolution is handled within DNS itself.) >> "%windir%\System32\drivers\etc\hosts"
(echo #	127.0.0.1       localhost) >> "%windir%\System32\drivers\etc\hosts"
(echo #	::1             localhost) >> "%windir%\System32\drivers\etc\hosts"
echo Host file reset.
goto "Start"

:"17"
echo.
echo Reseting WinHTTP proxy.
netsh winhttp reset autoproxy > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
netsh winhttp proxy reset > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo WinHTTP proxy reset.
goto "Start"

:"18"
echo.
echo Reseting Windows Defender Firewall to default.
netsh advfirewall reset > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo Windows Defender Firewall reset to default.
goto "Start"

:"Error"
echo There has been an error! You can try again.
goto "Start"

:"Close"
endlocal
exit
