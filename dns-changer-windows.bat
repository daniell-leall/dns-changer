@echo off
setlocal enabledelayedexpansion

:: Check if the script is being run as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ===================================================
    echo            WELCOME TO THE DNS CHANGER T00L
    echo ===================================================
    echo.
    echo [ERROR] WHOOPS! Looks like you don't have admin rights.
    echo.
    echo Please restart this script as Administrator to unleash its power!
    echo.
    pause
    exit /b
)

:: Ask the user which network interface they want to use
:AskInterface
cls
echo ===================================================
echo            WELCOME TO THE DNS CHANGER T00L
echo ===================================================
echo.
echo   Select the network interface to use:
echo.
echo   [1] Ethernet
echo   [2] Wi-Fi
echo.
echo ===================================================
echo.

set /p interface_choice="Enter your choice: "

:: Validate the network interface choice
if "%interface_choice%"=="1" (
    set INTERFACE_NAME="Ethernet"
) else if "%interface_choice%"=="2" (
    set INTERFACE_NAME="Wi-Fi"
) else (
    echo Invalid choice. Please select either 1 or 2.
    pause
    goto AskInterface
)

:: Function to check the current DNS configuration
:CheckDNS
cls
echo ===================================================
echo            WELCOME TO THE DNS CHANGER T00L
echo ===================================================
echo.
echo   Checking current DNS configuration...
echo.

:: Use PowerShell to get the configured DNS addresses
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
    echo   Current DNS is set to: -
    echo   Current primary DNS: [!dnsList!]
)

:: Show the menu options
echo.
echo   Select an option below:
echo.
echo   [1] Set DNS to Dynamic (DHCP)
echo   [2] Set Static Google DNS (8.8.8.8, 8.8.4.4)
echo   [3] Set Static Cloudflare DNS (1.1.1.1)
echo   [4] Set Static AdGuard DNS (94.140.14.140, 94.140.15.15)

echo   [5] Set Static OpenDNS Cisco (208.67.222.222, 208.67.220.22)
echo   [6] Set Static Quad9 DNS (9.9.9.9, 149.112.112.112)
echo   [7] Set Static CleanBrowsing DNS (185.228.168.168, 185.228.169.168)
echo   [8] Set Static Comodo Secure DNS (8.26.56.26, 8.20.247.20)

echo   [9] Set Static Local Pi-hole DNS (192.168.0.100)
echo   [10] Exit
echo.
echo ===================================================
echo.

set /p choice="Enter your choice: "

:: Process the user's choice
if "%choice%"=="1" goto SetDynamicDNS
if "%choice%"=="2" goto SetGoogleDNS
if "%choice%"=="3" goto SetCloudflareDNS
if "%choice%"=="4" goto SetAdGuardDNS

if "%choice%"=="5" goto OpenDNSCisco
if "%choice%"=="6" goto Quad9
if "%choice%"=="7" goto CleanBrowsing
if "%choice%"=="8" goto ComodoSecureDNS

if "%choice%"=="9" goto SetPiholeDNS
if "%choice%"=="10" goto ExitScript

:: Handle invalid choice
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

:SetCloudflareDNS
echo Setting DNS to Cloudflare (1.1.1.1)...
netsh interface ip set dns name=%INTERFACE_NAME% static 1.1.1.1
goto CheckDNS

:SetAdGuardDNS
echo Setting DNS to AdGuard (94.140.14.140, 94.140.15.15)...
netsh interface ip set dns name=%INTERFACE_NAME% static 94.140.14.140
netsh interface ip add dns name=%INTERFACE_NAME% 94.140.15.15 index=2
goto CheckDNS




:OpenDNSCisco
echo Setting DNS to OpenDNS Cisco (208.67.222.222, 8.8.4.4)...
netsh interface ip set dns name=%INTERFACE_NAME% static 208.67.222.222
netsh interface ip add dns name=%INTERFACE_NAME% 208.67.220.220 index=2
goto CheckDNS

:Quad9
echo Setting DNS to Quad9 (9.9.9.9, 149.112.112.112)...
netsh interface ip set dns name=%INTERFACE_NAME% static 9.9.9.9
netsh interface ip add dns name=%INTERFACE_NAME% 149.112.112.112 index=2
goto CheckDNS

:CleanBrowsing
echo Setting DNS to CleanBrowsing (185.228.168.168, 185.228.169.168)...
netsh interface ip set dns name=%INTERFACE_NAME% static 185.228.168.168
netsh interface ip add dns name=%INTERFACE_NAME% 185.228.169.168 index=2
goto CheckDNS

:ComodoSecureDNS
echo Setting DNS to Comodo Secure (8.26.56.26, 8.20.247.20)...
netsh interface ip set dns name=%INTERFACE_NAME% static 8.26.56.26
netsh interface ip add dns name=%INTERFACE_NAME% 8.20.247.20 index=2
goto CheckDNS




:SetPiholeDNS
echo Setting DNS to Local Pi-hole (192.168.0.100)...
netsh interface ip set dns name=%INTERFACE_NAME% static 192.168.0.100
goto CheckDNS

:ExitScript

:: Temporarily disable delayed expansion to display the exclamation mark
setlocal disableDelayedExpansion

cls
echo ============================================================
echo             THANK YOU FOR USING THE SCRIPT!
echo ============================================================
echo.
echo   Don't forget to:
echo.
echo   Follow me on Instagram:  @daniell.leall
echo   Subscribe to my channel on YouTube:  @daniell_leall
echo.
echo   Exiting script... Goodbye!
echo.
echo ============================================================

endlocal
pause
exit
