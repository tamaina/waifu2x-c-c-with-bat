@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
cd ..
echo .
echo !DATE! !TIME! twittermode.bat
:loop

if "%~1" == "" goto end
set dott_png=%TMP%\dott.png
set twitter_png=%~dp1\forTwitter_%~n1.png
set colorqual=256
convert -size 1x1 xc:#00000011 png32:"%dott_png%"
convert "%~1" "%twitter_png%"

composite -compose dst_out "%dott_png%" "%twitter_png%" -matte "%twitter_png%"
call :filesize "%twitter_png%"
if not !thesize! GTR 3000000 goto finish
echo !DATE! !TIME! �T�C�Y:!themegabite!MB
echo 3MB�������Ȃ������̂Ō��F���܂�...
goto quant
:return
echo !DATE! !TIME! �T�C�Y:!themegabite!MB
echo 3MB�������Ȃ������̂ł�����x���F���܂�...
:quant
set /A themegabite=!thesize! / 1000000
echo �F��:%colorqual%
pngquant --ext .png --speed 1 --force %colorqual% "%twitter_png%"
composite -compose dst_out "%dott_png%" "%twitter_png%" -matte "%twitter_png%"
call :filesize "%twitter_png%"
if !thesize! GTR 3000000 (
set /A colorqual=%colorqual% - 16
goto return
)
:finish
del "%dott_png%"
echo !DATE! !TIME! twitter�p�摜���������܂����B
echo �t�@�C����:"%twitter_png%"
echo .
shift
goto loop
:filesize
set thesize=%~z1
goto end
:end