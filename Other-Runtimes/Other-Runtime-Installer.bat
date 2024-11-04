@echo off
SETLOCAL ENABLEEXTENSIONS

@echo off
cd /d %~dp0

echo.
echo Installing OpenAL....
echo.

start /wait oalinst.exe /S
echo Successfully installed OpenAL.

echo.
echo Installing Microsoft XNA Framework Redistributable 4.0....
echo.

start /wait xnafx40_redist.msi /qr
echo Successfully installed Microsoft XNA Framework Redistributable 4.0

echo. 
echo All other packages are successfully installed.


