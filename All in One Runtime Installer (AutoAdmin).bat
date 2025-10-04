@echo off
setlocal enabledelayedexpansion

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

:: Ask the user if they want to continue running the script
echo Do you want to run the script? [Y/N]
choice /c YN /n /m "Press Y to continue or N to cancel: "
if errorlevel 2 goto end
if errorlevel 1 goto continue

:continue
@echo off
SETLOCAL ENABLEEXTENSIONS

echo Installing all the required runtime packages in your system....
echo.

REM KILL ANY RUNNING INSTANCES OF DISM OR TIWORKER TO AVOID ERRORS
TASKLIST | FINDSTR "Dism.exe TiWorker.exe" >NUL && TASKKILL /F /IM "Dism.exe" /IM "TiWorker.exe" /T >NUL 2>&1

@echo off
CD /d %~dp0

CALL "Visual-C-Runtimes\Install All Visual C++ Redistributable Runtimes.bat"
CALL "DirectX-Redist-Jun-2010\DirectX Runtime Offline Installer.bat"
CALL ".Net-Installers\.Net Installer.bat"
CALL "Other-Runtimes\Other-Runtime-Installer.bat"

ECHO Successfully installed all Microsoft's Visual C Runtimes, DotNet SDK LTS Runtimes, and DirectX!
ECHO.

ENDLOCAL

setlocal enabledelayedexpansion

echo.
echo A Reboot will be required to finish the Installation..
echo.

for /l %%i in (10,-1,1) do (
    cls
    echo Your computer will be restarted in %%i seconds.
    echo Press "N" to cancel or "R" to reboot immediately.
    choice /c NRT /t 1 /d T > nul
    if !errorlevel! equ 1 (
        echo.
        ENDLOCAL
        echo Restart Canceled. You can reboot later.
        echo.
        echo Press any key to exit...
        pause > nul
        exit /b
    ) else if !errorlevel! equ 2 (
        goto :reboot
    )
    echo.
)

:reboot
ENDLOCAL
echo Restarting now...
shutdown /r /t 0




