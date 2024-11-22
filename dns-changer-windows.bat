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
echo.
echo   [2] Set Static Google DNS (8.8.8.8, 8.8.4.4)
echo   [3] Set Static Cloudflare DNS (1.1.1.1)
echo   [4] Set Static AdGuard DNS (94.140.14.140, 94.140.15.15)
echo   [5] Set Static OpenDNS Cisco (208.67.222.222, 208.67.220.22)
echo   [6] Set Static Quad9 DNS (9.9.9.9, 149.112.112.112)
echo   [7] Set Static CleanBrowsing DNS (185.228.168.168, 185.228.169.168)
echo   [8] Set Static Comodo Secure DNS (8.26.56.26, 8.20.247.20)
echo.
echo   [9] Set Static Local Pi-hole DNS (192.168.0.100)
echo   [10] Setup a Manual DNS
echo.
echo   [11] Exit
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
if "%choice%"=="10" goto SetManualDNS
if "%choice%"=="11" goto ExitScript

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



:: Section of the script to set Manual DNS (Option 10)
:SetManualDNS
cls
echo ===================================================
echo                WELCOME TO THE DNS CHANGER T00L
echo ===================================================
echo.
echo   You have selected to set a Manual DNS.
echo.
echo   Please enter the IP address of the DNS server 
echo   you wish to use. Make sure it's in the correct 
echo   format (X.X.X.X):
echo.
set /p user_dns="   Enter DNS IP: "

:: Verify if the entered IP is valid (using simple validation)
echo Verifying the entered IP address...

:: Check if the IP is in the valid X.X.X.X format with numbers from 0 to 255
for /f "tokens=1-4 delims=." %%a in ("%user_dns%") do (
    set /a part1=%%a
    set /a part2=%%b
    set /a part3=%%c
    set /a part4=%%d
)

:: Check if each part of the IP is within the valid range (0-255)
if %part1% geq 0 if %part1% leq 255 if %part2% geq 0 if %part2% leq 255 if %part3% geq 0 if %part3% leq 255 if %part4% geq 0 if %part4% leq 255 (
    echo IP address is valid.
) else (
    echo Invalid IP address. Please enter a valid IP address.
    pause
    goto SetManualDNS
)

echo Setting DNS to %user_dns%...
netsh interface ip set dns name=%INTERFACE_NAME% static %user_dns%

:: Optional: Ask if the user wants to add a secondary DNS
set /p add_secondary_dns="Do you want to add a secondary DNS (Y/N)? "
if /i "%add_secondary_dns%"=="Y" (
    set /p secondary_dns="Enter secondary DNS IP: "
    
    :: Verify the secondary IP
    for /f "tokens=1-4 delims=." %%a in ("%secondary_dns%") do (
        set /a part1=%%a
        set /a part2=%%b
        set /a part3=%%c
        set /a part4=%%d
    )

    if %part1% geq 0 if %part1% leq 255 if %part2% geq 0 if %part2% leq 255 if %part3% geq 0 if %part3% leq 255 if %part4% geq 0 if %part4% leq 255 (
        echo Secondary IP address is valid.
    ) else (
        echo Invalid secondary IP address. Please enter a valid IP address.
        pause
        goto SetManualDNS
    )

    netsh interface ip add dns name=%INTERFACE_NAME% %secondary_dns% index=2
    echo Secondary DNS set to: %secondary_dns%
)

goto CheckDNS

:SetPiholeDNS
echo Setting DNS to Local Pi-hole (192.168.0.100)...
netsh interface ip set dns name=%INTERFACE_NAME% static 192.168.0.100
goto CheckDNS

:ExitScript
:: Disables variable expansion to correctly display the exclamation mark
setlocal disableDelayedExpansion

:: Setting the wait time in seconds (can be easily changed)
set WAIT_TIME=20

:: Clearing the screen and displaying the menu
cls
echo ============================================================
echo              THANK YOU FOR USING THIS SCRIPT!
echo ============================================================
echo.
echo   We will close automatically in %WAIT_TIME% seconds.
echo.
echo.
echo   Don't forget to follow me on:
echo.
echo   [1] Instagram
echo   [2] YouTube
echo   [3] GitHub
echo.
echo   [4] Buy Me a Coffee
echo.
echo.
echo ============================================================
echo.

:: Using the "choice" command to get user input with a 20-second timeout
choice /c 12345 /t %WAIT_TIME% /d 5 /n /m "Choose an option:"

:: Action to be executed based on the selected option
if %errorlevel%==5 (
    echo.
    echo   Exiting script... Goodbye!
    timeout /t 2 >nul
    exit
) else if %errorlevel%==1 (
    echo.
    echo Opening Instagram profile...
    timeout /t 2 >nul
    start https://www.instagram.com/daniell.leall/
) else if %errorlevel%==2 (
    echo.
    echo Opening YouTube profile...
    timeout /t 2 >nul
    start https://www.youtube.com/@prosecd?sub_confirmation=1
) else if %errorlevel%==3 (
    echo.
    echo Opening GitHub profile...
    timeout /t 2 >nul
    start https://github.com/daniell-leall
) else if %errorlevel%==4 (
    echo.
    echo Opening Buy Me a Coffee page...
    timeout /t 2 >nul
    start https://ko-fi.com/daniell_leall
)

goto ExitScript
