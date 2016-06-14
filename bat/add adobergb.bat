@echo off
:loop
if "%~1" == "" goto finish
echo convert rgb to cmyk
echo %DATE% %TIME% %~1
magick convert "%~1" -profile "C:\Windows\System32\spool\drivers\color\AdobeRGB1998.icc" "%~dpn1-added%~x1" >> colorspacelog.txt 2>>&1
shift
goto loop
:finish