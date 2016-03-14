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
echo !DATE! !TIME! サイズ:!themegabite!MB
echo 3MBを下回らなかったので減色します...
goto quant
:return
echo !DATE! !TIME! サイズ:!themegabite!MB
echo 3MBを下回らなかったのでもう一度減色します...
:quant
set /A themegabite=!thesize! / 1000000
echo 色数:%colorqual%
pngquant --ext .png --speed 1 --force %colorqual% "%twitter_png%"
composite -compose dst_out "%dott_png%" "%twitter_png%" -matte "%twitter_png%"
call :filesize "%twitter_png%"
if !thesize! GTR 3000000 (
set /A colorqual=%colorqual% - 16
goto return
)
:finish
del "%dott_png%"
echo !DATE! !TIME! twitter用画像が完成しました。
echo ファイル名:"%twitter_png%"
echo .
shift
goto loop
:filesize
set thesize=%~z1
goto end
:end