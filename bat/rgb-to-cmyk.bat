@echo off
:loop
if "%~1" == "" goto finish
echo convert rgb to cmyk
echo %DATE% %TIME% %~1
convert -profile "C:\Windows\System32\spool\drivers\color\sRGB Color Space Profile.icm" -colorspace sRGB "%~1" -profile "C:\Windows\System32\spool\drivers\color\JapanColor2011Coated.icc" -colorspace CMYK "%~dpn1-cmyk%~x1" >> colorspacelog.txt 2>>&1
exiftool -ColorSpace="ICC Profile" -InkSet#=1 -PhotometricInterpretation#=5 -InteropIndex="THM" "%~dpn1-cmyk%~x1" >> colorspacelog.txt 2>>&1
shift
goto loop
:finish