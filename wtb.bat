@echo off

rem 借りました→http://qiita.com/koryuohproject/items/815a1621bc34a223e4b9

if "%1" == "START"  goto BEGINb
if "%1" == "STOP"   goto ENDb
if "%1" == "PRINT"  goto PRINTb
goto EOF

:BEGINb
SET Tb=%TIME: =0%
SET Hb=%Tb:~0,2%
SET Mb=%Tb:~3,2%
SET Sb=%Tb:~6,2%
SET Lb=%Tb:~9,2%

rem --8進対策
set /a Hb=1%Hb%-100
set /a Mb=1%Mb%-100
set /a Sb=1%Sb%-100
goto EOF

:ENDb
SET T1b=%TIME: =0%
SET H1b=%T1b:~0,2%
SET M1b=%T1b:~3,2%
SET S1b=%T1b:~6,2%
SET L1b=%T1b:~9,2%

rem --8進対策
set /a H1b=1%H1b%-100
set /a M1b=1%M1b%-100
set /a S1b=1%S1b%-100
rem --終了時間の計算
SET /a H2b=H1b-Hb

SET /a M2b=M1b-Mb
if %M2b% LSS 0 set /a H2b=H2b-1
if %M2b% LSS 0 set /a M2b=M2b+60

SET /a S2b=S1b-Sb
if %S2b% LSS 0 set /a M2b=M2b-1
if %S2b% LSS 0 set /a S2b=S2b+60

SET /a L2b=L1b-Lb
if %L2b% LSS 0 set /a S2b=S2b-1
if %L2b% LSS 0 set /a L2b=L2b+100

rem 二けた強制表示
rem if %L2b% LSS 10 set L2b=0%L2b%

SET /a DPS=%H2b%*3600+%M2b%*60+%S2b%
SET DPS2=%DPSb%.%L2b%

set DPS_STAMP=%H2b%:%M2b%:%S2b%
set DPS_STAMP2=%DPS_STAMPb%.%L2b%

goto EOF

:PRINTb
echo 開始時間：%Tb%
echo 終了時間：%T1b%
echo 経過時間：%DPS_STAMPb%
echo 経過秒数：%DPS2b%
:EOF