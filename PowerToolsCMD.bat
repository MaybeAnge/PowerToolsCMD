

    ::
    ::  © Maybe Ange™ Corporation - All rights reserved.
    ::
    ::  This website is protected by copyright laws and is the property of Maybe Ange™ Corporation.
    ::  Any reproduction, modification, distribution or exploitation of all or part of the content of this site, in any form whatsoever, without prior written authorization, is strictly prohibited.
    ::  For any request for authorization or to obtain additional information on the rights to use the content of this site, please contact us via https://maybe-ange.com/#contact
    ::
    ::  License: CC-BY-ND-4.0
    ::
    

    @echo off
        net session >nul 2>&1
            if %errorlevel% neq 0 (
                echo.
                echo ^***************************************************^*
                echo ^*                                                  ^*
                echo ^*   Attention: You need to run this script         ^*
                echo ^*              as an administrator.                ^*
                echo ^*              Please restart the script as        ^*
                echo ^*              an administrator.                   ^*
                echo ^*                                                  ^*
                echo ^***************************************************^*
                echo.
                pause
                exit /b
            )
        setlocal enabledelayedexpansion
    cls

    :start
        echo.
        echo ^+---------------------------------------------^+
        echo ^|            Welcome to My Script             ^|
        echo ^+---------------------------------------------^+
        echo ^| Developer: DURAND Jimmy                     ^|
        echo ^| Org: Maybe Ange Corporation                 ^|
        echo ^+---------------------------------------------^+
        echo.
        
        echo Please note, CURL is required to have access to all features.
        echo.
        set /p show_ip=Do you want to display your Public IP Address? (Y/N): 
    cls

    :menu
        cls
            echo.
            echo %date%
            echo.
            echo Computer: %computername% --- User: %username%
            
            if /i "%show_ip%"=="Y" (
                for /f "delims=" %%i in ('powershell -Command "(Invoke-WebRequest -Uri 'https://api.ipify.org' -UseBasicParsing).Content"') do (
                    set "ipaddress=%%i"
                )
            ) else (
                set ipaddress=Hidden ***.***.***.***
            )

            for /f "tokens=*" %%i in ('curl -s ipinfo.io/org') do (
                set "provider=%%i"
            )

            reg query "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "Start" | findstr /i "Start" >nul
            if %errorlevel% equ 0 (
                for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "Start" ^| findstr /i "Start"') do (
                    if %%a equ 3 (
                        set USBStatus=Enabled
                    ) else if %%a equ 4 (
                        set USBStatus=Disabled
                    )
                )
            )
            
            echo.
            echo IP Address: %ipaddress%
            echo Internet Provider: %provider%
            echo.
            echo ^+---------------------------------------------^+
            echo ^|                  TASK MENU                  ^|
            echo ^+---------------------------------------------^+
            echo ^| 1. Empty Recycle Bin                        ^|
            echo ^| 2. Control Panel                            ^|
            echo ^| 3. System Information                       ^|
            echo ^| 4. Internet Speed Test                      ^|
            echo ^| 5. Install VLC                              ^|
            echo ^| 6. Disable USB ports                        ^|
            echo ^| 7. Apps update                              ^|
            echo ^| 8. Exit                                     ^|
            echo ^+---------------------------------------------^+
            echo.

    set /p option= Choose an option: 

    if %option% equ 1 goto option1
    if %option% equ 2 goto option2
    if %option% equ 3 goto option3
    if %option% equ 4 goto option4
    if %option% equ 5 goto option5
    if %option% equ 6 goto option6
    if %option% equ 7 goto option7
    if %option% equ 8 goto end
    if %option% GEQ 9 goto optionerror

    :option1
        cls
            echo.
            echo ^+---------------------------------------------^+
            echo ^|             Recycle Bin Emptied             ^|
            echo ^+---------------------------------------------^+
            echo.
            echo Please Wait, Deleting Trash in Progress...

    for /l %%i in (60,1,100) do (
        cls
            echo.
            echo ^+---------------------------------------------^+
            echo ^|             Recycle Bin Emptied             ^|
            echo ^+---------------------------------------------^+
            echo.
            echo Please Wait, Deleting Trash in Progress...
            echo Progress: %%i%%
        timeout /t 0 /nobreak > NUL
    )

        rd /S /Q c:\$Recycle.bin
        pause
    goto menu

    :option2
        cls
            echo.
            echo ^+---------------------------------------------^+
            echo ^|           Control Panel Opened              ^|
            echo ^+---------------------------------------------^+
            echo.
            control.exe
        pause
    goto menu

    :option3
        cls
            echo Retrieving System Information...
            echo Please Wait...
            timeout /t 5 /nobreak > NUL
            systeminfo
        pause
    goto menu

    :option4
        cls
            echo.
            echo ^+---------------------------------------------^+
            echo ^|         Welcome to Internet Speedtest       ^|
            echo ^|                                             ^|
            echo ^|         Running Internet Speed Test...      ^|
            echo ^+---------------------------------------------^+
            echo.
            echo API CURL: speedtest.tele2.net
            echo.
            curl -o NUL http://speedtest.tele2.net/100MB.zip
        pause
    goto menu

    :option5
        cls
            echo.
            echo ^+---------------------------------------------^+
            echo ^|                Install VLC                  ^|
            echo ^+---------------------------------------------^+
            echo.

            echo Installation by CMD, may be refused by antivirus.
            set /p vlc=Do you want to install VLC? (Y/N): 

            if /i "%vlc%"=="Y" (
                echo Downloading the VLC installer...
                certutil -urlcache -split -f "https://get.videolan.org/vlc/3.0.16/win64/vlc-3.0.16-win64.exe" "%TEMP%\vlc-3.0.16-win64.exe"

                echo Installing VLC...
                "%TEMP%\vlc-3.0.16-win64.exe" /S

                echo.
                echo Installation Completed.
            ) else (
                echo Installation Cancel.
            )
        pause
    goto menu

    :option6
        cls
            echo.
            echo ^+---------------------------------------------^+
            echo ^|              Disable USB ports              ^|
            echo ^+---------------------------------------------^+
            echo.
            echo 1. Disable USB ports
            echo 2. Enable USB ports
            echo 3. Back
            echo.

            set /p choice="Enter the number of your choice: "

            if "%choice%"=="1" goto disable_usb_ports
            if "%choice%"=="2" goto enable_usb_ports
            if "%choice%"=="3" goto menu

            echo Invalid choice. Try Again.
            pause
            goto menu

            :disable_usb_ports
            reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d 4 /f >nul
            echo USB ports have been successfully disabled.
            pause
            goto menu

            :enable_usb_ports
            reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d 3 /f >nul
            echo The USB ports have been successfully activated.
        pause
    goto menu

    :option7
        cls
            echo.
            echo ^+---------------------------------------------^+
            echo ^|                  TASK MENU                  ^|
            echo ^+---------------------------------------------^+
            echo ^| 1. Check Update                             ^|
            echo ^| 2. Update Now                               ^|
            echo ^| 3. Back                                     ^|
            echo ^+---------------------------------------------^+
            echo.

            set /p updateOption= Choose an option: 

            if %updateOption% equ 1 goto checkUpdate
            if %updateOption% equ 2 goto updateNow
            if %updateOption% equ 3 goto menu

            echo Invalid choice. Try Again.

            :checkUpdate
                cls
                    echo.
                    echo ^+---------------------------------------------^+
                    echo ^|                Check Update                 ^|
                    echo ^+---------------------------------------------^+
                    echo.
                    echo Checking for updates available...
                    winget update
                pause
            goto option7

            :updateNow
                cls
                    echo.
                    echo ^+---------------------------------------------^+
                    echo ^|                Check Update                 ^|
                    echo ^+---------------------------------------------^+
                    echo.
                    echo Installing updates...
                    winget update --all
                pause
            goto option7
        pause
    goto menu

    :optionerror
        cls
            echo.
            echo ^+---------------------------------------------^+
            echo ^|      Invalid Option! Choose from Menu       ^|
            echo ^+---------------------------------------------^+
            echo.
        pause
    goto menu

    :end
        cls
