@echo off

rem �؂�܂�����http://qiita.com/koryuohproject/items/815a1621bc34a223e4b9

if "%1" == "START"  goto BEGIN
if "%1" == "STOP"   goto END
if "%1" == "PRINT"  goto PRINT
goto EOF

:BEGIN
SET T=%TIME: =0%
SET H=%T:~0,2%
SET M=%T:~3,2%
SET S=%T:~6,2%
SET L=%T:~9,2%

rem --8�i�΍�
set /a H=1%H%-100
set /a M=1%M%-100
set /a S=1%S%-100
goto EOF

:END
SET T1=%TIME: =0%
SET H1=%T1:~0,2%
SET M1=%T1:~3,2%
SET S1=%T1:~6,2%
SET L1=%T1:~9,2%

rem --8�i�΍�
set /a H1=1%H1%-100
set /a M1=1%M1%-100
set /a S1=1%S1%-100
rem --�I�����Ԃ̌v�Z
SET /a H2=H1-H

SET /a M2=M1-M
if %M2% LSS 0 set /a H2=H2-1
if %M2% LSS 0 set /a M2=M2+60

SET /a S2=S1-S
if %S2% LSS 0 set /a M2=M2-1
if %S2% LSS 0 set /a S2=S2+60

SET /a L2=L1-L
if %L2% LSS 0 set /a S2=S2-1
if %L2% LSS 0 set /a L2=L2+100

rem �񂯂������\��
rem if %L2% LSS 10 set L2=0%L2%

SET /a DPS=%H2%*3600+%M2%*60+%S2%
SET DPS2=%DPS%.%L2%

set DPS_STAMP=%H2%:%M2%:%S2%
set DPS_STAMP2=%DPS_STAMP%.%L2%

goto EOF

:PRINT 
echo �J�n���ԁF%T%
echo �I�����ԁF%T1%
echo �o�ߎ��ԁF%DPS_STAMP%
echo �o�ߕb���F%DPS2%
:EOF