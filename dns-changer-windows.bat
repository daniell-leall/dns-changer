@echo off
setlocal enabledelayedexpansion

:: Check if the script is being run as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] This script must be run as Administrator. Please restart with elevated privileges.
    pause
    exit /b
)

:: Define the name of the network interface
set INTERFACE_NAME="Wi-Fi"

:: Function to check the current DNS configuration
:CheckDNS
cls
echo ==========================================
echo   WELCOME TO THE DNS CHANGER T00L
echo ==========================================
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
    echo   Current DNS is set to: 
    echo   Current primary DNS: [!dnsList!]
)

:: Show the menu options
echo.
echo   Select an option below:
echo   [1] Set DNS to Dynamic (DHCP)
echo   [2] Set Static Google DNS (8.8.8.8, 8.8.4.4)
echo   [3] Set Static Cloudflare DNS (1.1.1.1)
echo   [4] Set Static Local Pi-hole DNS (192.168.0.100)
echo   [5] Exit
echo.
echo   Follow me on Instagram: @daniell.leall
echo ==========================================
echo.

set /p choice="Enter your choice: "

:: Process the user's choice
if "%choice%"=="1" goto SetDynamicDNS
if "%choice%"=="2" goto SetGoogleDNS
if "%choice%"=="3" goto SetCloudflareDNS
if "%choice%"=="4" goto SetPiholeDNS
if "%choice%"=="5" goto ExitScript

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

:SetPiholeDNS
echo Setting DNS to Local Pi-hole (192.168.0.100)...
netsh interface ip set dns name=%INTERFACE_NAME% static 192.168.0.100
goto CheckDNS

:ExitScript
echo Exiting script. Goodbye!
pause
exit
