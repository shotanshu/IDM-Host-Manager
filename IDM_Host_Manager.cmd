@echo off
setlocal enabledelayedexpansion

:MENU
cls
echo.
echo ================================================
echo               IDM HOST MANAGER
echo ================================================
echo.
echo      [1] Block IDM-related domains
echo      [2] Unblock IDM-related domains
echo      [3] Set file hosts to read-only
echo      [4] Restore file hosts access to default
echo      [5] Check if domains are blocked
echo      [6] Exit
echo.
echo ================================================
echo            Created by Shotanshu
echo ================================================
set /p choice=Choose an option (1-6): 

if "%choice%"=="1" goto BLOCK_IDM
if "%choice%"=="2" goto UNBLOCK_IDM
if "%choice%"=="3" goto SET_READONLY
if "%choice%"=="4" goto RESTORE_ACCESS
if "%choice%"=="5" goto CHECK_BLOCKED
if "%choice%"=="6" exit

echo Invalid choice. Please select an option between 1 and 6.
pause
goto MENU

:BLOCK_IDM
cls
echo ===============================
echo ADDING BLOCK ENTRIES
echo ===============================
:: Check if the file is read-only
for /f "tokens=*" %%A in ('icacls "%SystemRoot%\System32\drivers\etc\hosts" 2^>nul ^| findstr /i "DENY Everyone:(W)"') do set "readOnly=1"

if defined readOnly (
    color 4F
    echo ===============================
    echo ERROR: The hosts file is set to read-only.
    echo ===============================
    echo Please use option 4 to restore file access to default before blocking domains.
    echo ===============================
    pause
    color 07
    goto MENU
)

:: Adding block entries
echo Adding block entries for IDM-related domains to hosts file...
(
    echo #Internet Download Manager
    echo 127.0.0.1 tonec.com
    echo 127.0.0.1 www.tonec.com
    echo 127.0.0.1 registeridm.com
    echo 127.0.0.1 www.registeridm.com
    echo 127.0.0.1 secure.registeridm.com
    echo 127.0.0.1 internetdownloadmanager.com
    echo 127.0.0.1 www.internetdownloadmanager.com
    echo 127.0.0.1 secure.internetdownloadmanager.com
    echo 127.0.0.1 mirror.internetdownloadmanager.com
    echo 127.0.0.1 mirror2.internetdownloadmanager.com
    echo 127.0.0.1 mirror3.internetdownloadmanager.com
    echo 127.0.0.1 star.tonec.com
) >> "%SystemRoot%\System32\drivers\etc\hosts"

if errorlevel 1 (
    color 4F
    echo ===============================
    echo FAILED TO ADD BLOCK ENTRIES
    echo ===============================
    echo Failed to add block entries. Access may be denied or file may be read-only.
    echo ===============================
    pause
    color 07
    goto MENU
)

color 2F
echo ===============================
echo BLOCK ENTRIES ADDED SUCCESSFULLY
echo ===============================
pause
color 07
goto MENU

:UNBLOCK_IDM
cls
echo ===============================
echo REMOVING BLOCK ENTRIES
echo ===============================
:: Check if the file is read-only
for /f "tokens=*" %%A in ('icacls "%SystemRoot%\System32\drivers\etc\hosts" 2^>nul ^| findstr /i "DENY Everyone:(W)"') do set "readOnly=1"

if defined readOnly (
    color 4F
    echo ===============================
    echo ERROR: The hosts file is set to read-only.
    echo ===============================
    echo Please use option 4 to restore file access to default before unblocking domains.
    echo ===============================
    pause
    color 07
    goto MENU
)

:: Removing block entries
echo Removing block entries for IDM-related domains from hosts file...
set "tempFile=%TEMP%\hosts_temp"
(for /f "usebackq delims=" %%A in ("%SystemRoot%\System32\drivers\etc\hosts") do (
    echo %%A | findstr /v /c:"127.0.0.1 tonec.com" | findstr /v /c:"127.0.0.1 www.tonec.com" | findstr /v /c:"127.0.0.1 registeridm.com" | findstr /v /c:"127.0.0.1 www.registeridm.com" | findstr /v /c:"127.0.0.1 secure.registeridm.com" | findstr /v /c:"127.0.0.1 internetdownloadmanager.com" | findstr /v /c:"127.0.0.1 www.internetdownloadmanager.com" | findstr /v /c:"127.0.0.1 secure.internetdownloadmanager.com" | findstr /v /c:"127.0.0.1 mirror.internetdownloadmanager.com" | findstr /v /c:"127.0.0.1 mirror2.internetdownloadmanager.com" | findstr /v /c:"127.0.0.1 mirror3.internetdownloadmanager.com" | findstr /v /c:"127.0.0.1 star.tonec.com" >> "%tempFile%"
)) >nul
move /y "%tempFile%" "%SystemRoot%\System32\drivers\etc\hosts" >nul

if errorlevel 1 (
    color 4F
    echo ===============================
    echo FAILED TO REMOVE BLOCK ENTRIES
    echo ===============================
    echo Failed to remove block entries. Access may be denied or file may be read-only.
    echo ===============================
    pause
    color 07
    goto MENU
)

color 2F
echo ===============================
echo BLOCK ENTRIES REMOVED SUCCESSFULLY
echo ===============================
pause
color 07
goto MENU

:SET_READONLY
cls
echo ===============================
echo SETTING FILE HOSTS TO READ-ONLY
echo ===============================
echo Setting file hosts to read-only...
icacls "%SystemRoot%\System32\drivers\etc\hosts" /deny Everyone:(W) >nul 2>&1
if errorlevel 1 (
    color 4F
    echo ===============================
    echo FAILED TO SET FILE HOSTS TO READ-ONLY
    echo ===============================
    echo Failed to set file hosts to read-only. Check your permissions.
    echo ===============================
    pause
    color 07
    goto MENU
)
color 2F
echo ===============================
echo FILE HOSTS SET TO READ-ONLY
echo ===============================
pause
color 07
goto MENU

:RESTORE_ACCESS
cls
echo ===============================
echo RESTORING FILE HOSTS ACCESS TO DEFAULT
echo ===============================
echo Restoring file hosts access to default...
icacls "%SystemRoot%\System32\drivers\etc\hosts" /reset >nul 2>&1
if errorlevel 1 (
    color 4F
    echo ===============================
    echo FAILED TO RESTORE FILE HOSTS ACCESS
    echo ===============================
    echo Failed to restore file hosts access. Check your permissions.
    echo ===============================
    pause
    color 07
    goto MENU
)
color 2F
echo ===============================
echo FILE HOSTS ACCESS RESTORED TO DEFAULT
echo ===============================
pause
color 07
goto MENU

:CHECK_BLOCKED
cls
echo ===============================
echo CHECKING BLOCKED DOMAINS
echo ===============================
set "file=%SystemRoot%\System32\drivers\etc\hosts"
set "domains=tonec.com www.tonec.com registeridm.com www.registeridm.com secure.registeridm.com internetdownloadmanager.com www.internetdownloadmanager.com secure.internetdownloadmanager.com mirror.internetdownloadmanager.com mirror2.internetdownloadmanager.com mirror3.internetdownloadmanager.com star.tonec.com"
set "found=0"

:: Flush DNS cache
echo Flushing DNS cache...
ipconfig /flushdns >nul 2>&1

:: Check if domains are blocked using nslookup
for %%D in (%domains%) do (
    echo Pinging %%D to check if it is blocked...
    for /f "tokens=2 delims=[]" %%A in ('nslookup %%D 2^>nul ^| findstr /i "Address"') do (
        if "%%A"=="127.0.0.1" (
            echo ===============================
            echo DOMAIN BLOCKED: %%D
            echo ===============================
        ) else (
            color 4F
            echo ===============================
            echo DOMAIN NOT BLOCKED: %%D
            echo ===============================
            set "found=1"
        )
    )
)

if !found! equ 0 (
    color 2F
    echo ===============================
    echo ALL DOMAINS ARE BLOCKED
    echo ===============================
) else (
    color 4F
    echo ===============================
    echo SOME DOMAINS ARE NOT BLOCKED
    echo ===============================
)

pause
color 07
goto MENU
