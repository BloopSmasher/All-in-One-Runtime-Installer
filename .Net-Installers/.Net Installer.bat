@echo off
SETLOCAL ENABLEEXTENSIONS

@echo off
cd /d %~dp0

echo.
echo Installing Essential .NET Frameworks and SDKs....
echo.

:: Install .NET SDK 8.0.401
echo Installing .NET SDK 8.0.401...
start /wait dotnet-sdk-8.0.401-win-x64.exe /passive /norestart

:: Install .NET Framework 3.5
echo Installing .NET Framework 3.5...
start /wait dotnetfx35.exe /passive /norestart

:: Install .NET Framework 4.8
echo Installing .NET Framework 4.8...
start /wait NDP48-x86-x64-AllOS-ENU.exe /passive /norestart

echo.
echo All installations completed successfully.

ENDLOCAL
