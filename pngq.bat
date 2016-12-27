cd /d "%~dp0"
:loop
if "%~1" == "" goto end
pngquant.exe --ext -m.png --speed 1 "%~1"
shift
goto loop
:end
pause