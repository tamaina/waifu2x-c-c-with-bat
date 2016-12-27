@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
cd ..
:loop
if "%~1" == "" goto end
mkdir "%~dp1\fs8"
pngquant --speed 1 -o "%~dp1\fs8\%~nx1" "%~1"
:finish
echo .
shift
goto loop
:end