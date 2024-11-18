@echo off
setlocal enabledelayedexpansion

:: Define the network interface name
set INTERFACE_NAME="Wi-Fi"

:: Function to check the current DNS
:CheckDNS
cls
echo Checking current DNS configuration...

:: Using PowerShell to retrieve the configured DNS
set dnsList=
for /f "delims=" %%A in ('powershell -Command "(Get-DnsClientServerAddress -InterfaceAlias %INTERFACE_NAME%).ServerAddresses"') do (
    set dnsList=!dnsList!%%A,
)

:: Remove the trailing comma, if it exists
if defined dnsList (
    set dnsList=!dnsList:~0,-1!
)

:: Display the configured DNS
if defined dnsList (
    echo Current DNS is set to: 
    echo Current primary DNS: [!dnsList!]
)

:: Display menu
echo.
echo Select an option:
echo 1. Set DNS to Dynamic (DHCP)
echo 2. Set Static Google DNS (8.8.8.8, 8.8.4.4)
echo 3. Set Static Local Pi-hole DNS (192.168.0.100)
echo 4. Exit
echo.
set /p choice="Enter your choice: "

:: Process the choice
if "!choice!" equ "1" goto SetDynamicDNS
if "!choice!" equ "2" goto SetGoogleDNS
if "!choice!" equ "3" goto SetPiholeDNS
if "!choice!" equ "4" goto ExitScript

:: If the choice is invalid
echo Invalid choice. Please try again.
pause
goto CheckDNS

:SetDynamicDNS
echo Setting DNS to Dynamic (DHCP)...
netsh interface ip set dns name=%INTERFACE_NAME% dhcp
goto CheckDNS

:SetGoogleDNS
echo Setting DNS to Google (8.8.8.8, 8.8.4.4)...
netsh interface ip set dns name=%INTERFACE_NAME% static 8.8.8.8
netsh interface ip add dns name=%INTERFACE_NAME% 8.8.4.4 index=2
goto CheckDNS

:SetPiholeDNS
echo Setting DNS to Local Pi-hole (192.168.0.100)...
netsh interface ip set dns name=%INTERFACE_NAME% static 192.168.0.100
goto CheckDNS

:ExitScript
echo Exiting script. Goodbye!
pause
exit