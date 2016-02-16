@echo off

rem 借りました→http://qiita.com/koryuohproject/items/815a1621bc34a223e4b9

if "%1" == "START"  goto BEGINa
if "%1" == "STOP"   goto ENDa
if "%1" == "PRINT"  goto PRINTa
goto EOF

:BEGINa
SET Ta=%TIME: =0%
SET Ha=%Ta:~0,2%
SET Ma=%Ta:~3,2%
SET Sa=%Ta:~6,2%
SET La=%Ta:~9,2%

rem --8進対策
set /a Ha=1%Ha%-100
set /a Ma=1%Ma%-100
set /a Sa=1%Sa%-100
goto EOF

:ENDa
SET T1a=%TIME: =0%
SET H1a=%T1a:~0,2%
SET M1a=%T1a:~3,2%
SET S1a=%T1a:~6,2%
SET L1a=%T1a:~9,2%

rem --8進対策
set /a H1a=1%H1a%-100
set /a M1a=1%M1a%-100
set /a S1a=1%S1a%-100
rem --終了時間の計算
SET /a H2a=H1a-Ha

SET /a M2a=M1a-Ma
if %M2a% LSS 0 set /a H2a=H2a-1
if %M2a% LSS 0 set /a M2a=M2a+60

SET /a S2a=S1a-Sa
if %S2a% LSS 0 set /a M2a=M2a-1
if %S2a% LSS 0 set /a S2a=S2a+60

SET /a L2a=L1a-La
if %L2a% LSS 0 set /a S2a=S2a-1
if %L2a% LSS 0 set /a L2a=L2a+100

rem 二けた強制表示
rem if %L2a% LSS 10 set L2a=0%L2a%

SET /a DPSa=%H2a%*3600+%M2a%*60+%S2a%
SET DPS2a=%DPSa%.%L2a%

set DPS_STAMPa=%H2a%:%M2a%:%S2a%
set DPS_STAMP2a=%DPS_STAMPa%.%L2a%

goto EOF

:PRINTa
echo 開始時間：%Ta%
echo 終了時間：%T1a%
echo 経過時間：%DPS_STAMPa%
echo 経過秒数：%DPS2a%
:EOF
