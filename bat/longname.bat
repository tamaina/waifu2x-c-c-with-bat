@echo off
set TempFolder="%TMP%\longname"
mkdir %TempFolder% > NUL 2>&1
copy %1 %TempFolder% > NUL 2>&1
for /f "delims=" %%r in ( 'dir /B %TempFolder%' ) do (
set longname=%%r
)
echo %longname%
DEL "%TempFolder%\%longname%"