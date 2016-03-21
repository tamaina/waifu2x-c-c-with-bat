@echo off
:loop
if "%~1" == "" goto finish
echo convert rgb to cmyk
echo %DATE% %TIME% %~1
convert  -profile "C:\Windows\System32\spool\drivers\color\JapanColor2011Coated.icc" -colorspace CMYK "%~1" -profile "C:\Windows\System32\spool\drivers\color\sRGB Color Space Profile.icm" -colorspace sRGB "%~dpn1-sRGB%~x1">> colorspacelog.txt 2>>&1
exiftool -PreviewColorSpace#=2 -ColorSpace="sRGB" -InkSet#=1 -PhotometricInterpretation#=2 -InteropIndex="R98" "%~dpn1-cmyk%~x1" >> colorspacelog.txt 2>>&1
shift
goto loop
:finish