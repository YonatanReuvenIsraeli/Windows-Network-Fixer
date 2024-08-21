@echo off
title Windows Network Fixer
setlocal
echo Program Name: Windows Network Fixer
echo Version: 1.0.2
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
echo Network view:
echo [1] View current network status.
echo.
echo Network Repairs:
echo [2] Release and renew IP address(es).
echo [3] Flush DNS.
echo [4] Reset TCP/IP stack.
echo [5] Reset Winsock catalog.
echo.
echo Firewall Repairs:
echo [6] Set Windows Firewall rules to defualt.
set Repair=
echo.
set /p Repair="What do you want to do? (1-6) "
if /i "%Repair%"=="1" goto "1"
if /i "%Repair%"=="2" goto "2"
if /i "%Repair%"=="3" goto "3"
if /i "%Repair%"=="4" goto "4"
if /i "%Repair%"=="5" goto "5"
if /i "%Repair%"=="6" goto "6"
echo Invalid syntax!
goto "Start"

:"1"
ipconfig /all
if not "%errorlevel%"=="0" goto "Error"
goto "Start"

:"2"
echo.
echo Releasing and renewing IP address(es).
ipconfig /release > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
ipconfig /renew > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo IP address(es) released and renewed.
goto "Start"

:"3"
echo.
echo Flushing DNS.
ipconfig /flushdns > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo DNS flushed.
goto "Start"

:"4"
set regini=
if exist "%cd%\regini.txt" goto "reginiExist"
echo.
echo Reseting TCP/IP stack.
echo HKLM\SYSTEM\CurrentControlSet\Control\Nsi\{eb004a00-9b1a-11d4-9123-0050047759bc}\26 [1] > "%cd%\regini.txt"
regini "%cd%\regini.txt" > nul 2>&1
del "%cd%\regini.txt" /f /q
netsh int ip reset > nul 2>&1
if "%regini%"=="True" goto "reginiDone"
goto "Restart"

:"reginiExist"
set regini=True
echo.
echo Please temporary rename to something else or temporary move to another location "%cd%\regini.txt" in order for this batch file to proceed. Press any key to continue when "%cd%\regini.txt" is renamed to something else or moved to another location. This batch file will let you know when you can rename it back to its original name or move it back to its original location.
pause > nul 2>&1
goto "3"

:"reginiDone"
echo.
echo You can now rename or move back the file back to "%cd%\regini.txt".
goto "Restart"

:"Restart"
endlocal
echo Restart needed to finish reseting TCP/IP stack. Press any key to restart this PC.
pause > nul 2>&1
shutdown /r /t 00
goto "Start"

:"5"
echo.
echo Reseting Winsock catalog.
netsh winsock reset > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo Winsock catalog reset.
goto "Start"

:"6"
echo.
echo Reseting Windows Firewall to defualt.
netsh advfirewall reset > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo Windows Firewall reset to defualt.
goto "Start"

:"Error"
echo There has been an error! You can try again.
goto "Start"

:"Close"
endlocal
exit
