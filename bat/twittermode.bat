@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
cd ..
echo .
echo !DATE! !TIME! twittermode.bat
set dott_png=%TMP%dott.png
set twitter_png=%~dp1\forTwitter_%~n1.png
set forcesetting=256
convert -size 1x1 xc:#00000011 png32:"%dott_png%"
convert "%~1" "%twitter_png%"

composite -compose dst_out "%dott_png%" "%twitter_png%" -matte "%twitter_png%"
call :filesize "%twitter_png%"
if not !thesize! GTR 3000000 goto finish

:return
echo !DATE! !TIME! サイズ:!thesize!バイト 3MBを下回らなかったのでもう一度減色します...
echo pngquant 色数:%forcesetting%
pngquant --ext .png --speed 1 --force %forcesetting% "%twitter_png%"
composite -compose dst_out "%dott_png%" "%twitter_png%" -matte "%twitter_png%"
call :filesize "%twitter_png%"
if !thesize! GTR 3000000 (
set /A forcesetting=%forcesetting% - 16
goto return
)
:finish
del "%dott_png%"
echo !DATE! !TIME! twitter用画像が完成しました。
echo ファイル名:"%twitter_png%"
echo .
goto end
:filesize
set thesize=%~z1
goto end
:end