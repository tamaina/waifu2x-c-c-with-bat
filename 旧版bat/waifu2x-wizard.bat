@echo off
:=============================================================
:#############################################################
:����
:#############################################################
: �E�B�U�[�h���[�h�ł�
:waifu�̐ݒ��bat�ɒ��ڏ����̂ł͂Ȃ��A
:����bat�����s���Đݒ肵�Ă��������B
:#############################################################
:������
:#############################################################
:�E�o�͉摜����
: [���摜��]_waifu2xco-[�������[�h]-Lv[�m�C�YLv]-[�g�嗦]x.jpg
:  �ƂȂ�܂��B
:
:�i��j
:�@�@waifu2xco-noise_scale-Lv1-4x_asoboy.jpg
:
:
:�ȉ��͑I���I�v�V�����̑I�����̐ݒ�����˂��E�B�U�[�h��
:���s�R�[�h�ł��B�M��̂͏㋉�Ҍ����H
:=============================================================
:
:�҂�����
:

set waitingtime=60

: �b
:=============================================================
:
:�o�̓t�H���_�������l
:

set outfolder=waifued

: �����l�ł�
:=============================================================



:choice000
choice /N /C AB /T %waitingtime% /D B /M "[model]���f����I��[A:anime_style_art_rgb(�A�j���Ȃ�)/B:photo(�ʐ^�Ȃ�)]"
if errorlevel 2 (
 set model01=photo
 echo -photo(�ʐ^)
 goto choice00
 )
 set model01=anime_style_art_rgb
 echo -anime_style_art_rgb(�A�j���Ȃ�)
:choice00
choice /C YN /T %waitingtime% /D Y /M "[usew2x]caffe/converter-cpp�ǂ�����g�p���邩�����Ō��肵�܂���"
if "%errorlevel%" == "1" (
 echo -�w�肷��
 goto choice01
 ) else (
 echo -�w�肵�Ȃ�
 set ccchoice=
 )
choice /N /C AP /T %waitingtime% /D A /M "[usew2x]�ł́Acaffe/converter-cpp�ǂ�����g�p���܂���[A:caffe,P:cpp]?"
if errorlevel 2 (
 set ccchoice=cpp
 echo -cpp�o�[�W����
 ) else (
 set ccchoice=caffe
 echo -caffe�o�[�W����
 )

:choice01
choice /C YN /T %waitingtime% /D Y /M "[auto_scale]�m�C�Y�����@�\��jpeg�摜�݂̂ō쓮�����܂���"
if errorlevel 2 goto choice02
echo -����
set mode01=auto_scale
goto choice02kakunin

:choice02
choice /C YN /T %waitingtime% /D Y /M "[noise]�m�C�Y���������܂���"
if errorlevel 2 (
 set noisechoice=no
 echo -���Ȃ�
 goto choice02a
 )
set noisechoice=yes
echo -����
choice /N /C 12 /T %waitingtime% /D Y /M "[noise_level]�m�C�Y�������x�������[1/2]"
set noise_level=%errorlevel%

:choice02a
choice /C YN /T %waitingtime% /D Y /M "[scale]�g�債�܂���"
if errorlevel 2 (
 set scalechoice=no
 echo -���Ȃ�
 goto choicetovarm
 )
set scalechoice=yes
echo -����
set /P scale_ratio01=�g�嗦�𔼊p�����œ���[������]:

:choicetovarm

if "%noisechoice%" == "no" (
 if "%scalechoice%" == "yes" (
 set mode01=scale
 if "%scalechoice%" == "no" (
 echo .
 echo ���������Ȃ��C�ł����H�Ȃ�J�����Ӗ��Ȃ�����Ȃ��ł����B������񃂁[�h�ݒ����蒼���Ă��Ă��������B
 echo .
 goto choice01
 )
 ) else (
 if "%scalechoice%" == "yes" (
 set mode01=noise_scale
 if "%scalechoice%" == "no" (
 set mode01=noise
 )

:choice02kakunin
choice /N /C YFN /T %waitingtime% /D Y /M "[�m�F]waifu2x���샂�[�h��%mode01%�ł��B��낵���ł���[Y:����,N:���[�h�ݒ肩���蒼��,F:�ŏ������蒼��]?"
if errorlevel 3 goto choice02
if errorlevel 2 goto choice00

:choice03
choice /C YN /T %waitingtime% /D Y /M "[bat�Ǝ�]�t�H���_����������Ƃ��A�T�u�t�H���_���������܂���"
if errorlevel 2 (
 echo -���Ȃ�
 set subf01=false
 ) else ( 
 echo -����
 set subf01=true
 )

:choice04
choice /N /C YN /T %waitingtime% /D Y /M "��{�ݒ�͏I���ł��B����ŏ������J�n���܂�����낵���ł���[Y,N]?N��I������Ƃ��ڍׂȐݒ�Ɉڂ�܂��B"
if "%errorlevel%" == "1" goto finishchoosing
:choice05
choice /C YN /T %waitingtime% /D N /M "[caffe]�o�͎��̊g���q���w�肵�܂���[�f�t�H���g�l:png]"
if errorlevel 2 (
 echo -���Ȃ�
 set out_ext01=png
 goto choice06
 )
 echo -����
set /P out_ext01=�o�͉摜�̊g���q�����("."�͗v��܂���)

:choice06
choice /C YN /T %waitingtime% /D N /M "[caffe]���͂���摜�̊g���q���w�肵�܂���[�f�t�H���g�l��png:jpg:jpeg:tif:tiff:bmp:tga]"
if errorlevel 2 (
 echo -���Ȃ�
 set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga
 goto choice06a
 )
 echo -����
set /P inexli01=���͉摜�̊g���q�����("."�͗v��܂���/":"�ŋ�؂�܂�/"�["�͋�؂�L�����y����܂���z)

:choice06a
choice /C YN /T %waitingtime% /D N /M "[����]�o�̓t�H���_����ύX���܂����H �����l:%outfolder%(bat�𒼐ڊJ���ĕύX��)"

if errorlevel 2 (
 echo -���Ȃ�
 goto choice07
 )
 echo -����
set /P outfolder=�o�̓t�H���_���ύX(���������Ȃ��Ɠ����t�H���_�ɏo�͂��܂�)

:choice07
echo �ȏ�Őݒ�͏I���ł��B
choice /C YN /T %waitingtime% /D Y /M "�������J�n���܂����HN�������ƍŏ�����ݒ肵�܂��B"
if errorlevel 2 goto choice00


:finishchoosing
echo %~1


:����

setlocal enabledelayedexpansion
set process01=gpu
set datcdd=%~d0
set datcdp=%~p0
set datcdn=%~n0
goto ffjudge

:restart
if "%~1" == "" goto Finish_w2x


:ffjudge

pushd %~1
set pushderrorlv=%ErrorLevel%
if "%pushderrorlv%" GEQ "1" (
 set folder=false
 goto s_file
) else (
 popd
 set folder=true
 goto s_folder
)

:s_file

mkdir %~dp1\%outfolder%
set logname=%~dp1\%outfolder%\w2xresult
echo %DATE% %TIME% �t�@�C�����[�h
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [�t�@�C�����[�h] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dp1\%outfolder%"���쐬
echo %DATE% %TIME% "%logname%.log"���쐬(���łɂ���ꍇ�͒ǋL���܂��B)
cd /d %datcdd%%datcdp% >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
goto next1

:s_folder

mkdir %~dpn1\%outfolder%
set logname=%~dpn1\%outfolder%\w2xresult
echo %DATE% %TIME% �t�H���_���[�h
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [�t�H���_���[�h] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dpn1\%outfolder%"���쐬
echo %DATE% %TIME% "%logname%.log"���쐬(���łɂ���ꍇ�͒ǋL���܂��B)
cd /d %datcdd%%datcdp% >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
if "%usewaifu%" == "true" (
 goto next1
 ) else if "%usewaifu%" == "waifu2x-converter_x64" (
 goto w2xco_folder
 ) else if "%usewaifu%" == "waifu2x-converter" (
 goto w2xco_folder
 ) else (
 goto w2xca_folder
 )


:next1

call wta.bat START

:CPU���o
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
 if "%ccchoice%" == "caffe" (
 set usewaifu=waifu2x-caffe
 echo %DATE% %TIME% 64bitCPU�����o���܂����Bwaifu2x-caffe�ŏ������܂��B
 echo %DATE% %TIME% 64bitCPU�����o���܂����Bwaifu2x-caffe�ŏ������܂��B >>%logname%.log 2>>&1
 if "%folder%" == "true" (
  echo %DATE% %TIME% �t�H���_���[�h >>%logname%.log 2>>&1
  echo %DATE% %TIME% �t�H���_���[�h
  goto w2xca_folder
  ) else (
  echo %DATE% %TIME% �t�@�C�����[�h >>%logname%.log 2>>&1
  echo %DATE% %TIME% �t�@�C�����[�h
  goto w2xca_file
  )
 ) else if "%ccchoice%" == "cpp" (
set usewaifu=waifu2x-converter_x64
 echo %DATE% %TIME% 64bitCPU�����o���܂����Bwaifu2x-converter_x64�ŏ������܂��B
 echo %DATE% %TIME% 64bitCPU�����o���܂����Bwaifu2x-converter_x64�ŏ������܂��B >>%logname%.log 2>>&1
  if "%folder%" == "true" (
  echo %DATE% %TIME% �t�H���_���[�h >>%logname%.log 2>>&1
  echo %DATE% %TIME% �t�H���_���[�h
  goto w2xco_folder
  ) else (
  echo %DATE% %TIME% �t�@�C�����[�h >>%logname%.log 2>>&1
  echo %DATE% %TIME% �t�@�C�����[�h
  goto w2xco_file
  )
 ) else (
 set usewaifu=waifu2x-caffe
 echo %DATE% %TIME% 64bitCPU�����o���܂����B�͂��߂�waifu2x-caffe�ŏ������܂��B
 echo %DATE% %TIME% 64bitCPU�����o���܂����B�͂��߂�waifu2x-caffe�ŏ������܂��B >>%logname%.log 2>>&1
  if "%folder%" == "true" (
  echo %DATE% %TIME% �t�H���_���[�h >>%logname%.log 2>>&1
  echo %DATE% %TIME% �t�H���_���[�h
  goto w2xca_folder
  ) else (
  echo %DATE% %TIME% �t�@�C�����[�h >>%logname%.log 2>>&1
  echo %DATE% %TIME% �t�@�C�����[�h
  goto w2xca_file
  )
 )
 ) else (
 set usewaifu=waifu2x-converter
echo %DATE% %TIME% 32bitCPU�����o���܂����B
echo %DATE% %TIME% 32bitCPU�����o���܂����B >>%logname%.log 2>>&1
 if "%ccchoice%" == "caffe" (
 echo caffe�ł�32bit�łł͎g���܂���B32bit��waifu2x-converter�ŏ������܂��B
 echo caffe�ł�32bit�łł͎g���܂���B32bit��waifu2x-converter�ŏ������܂��B >>%logname%.log 2>>&1
 ) else (
 echo 32bit��waifu2x-converter�ŏ������܂��B >>%logname%.log 2>>&1
 echo 32bit��waifu2x-converter�ŏ������܂��B >>%logname%.log 2>>&1
 )
  if "%folder%" == "true" (
  echo %DATE% %TIME% �t�H���_���[�h >>%logname%.log 2>>&1
  echo %DATE% %TIME% �t�H���_���[�h
  goto w2xco_folder
  ) else (
  echo %DATE% %TIME% �t�@�C�����[�h >>%logname%.log 2>>&1
  echo %DATE% %TIME% �t�@�C�����[�h
  goto w2xco_file
  )
 )
 

echo %DATE% %TIME% �����������������܂����B >>%logname%.log 2>>&1
echo %DATE% %TIME% �����������������܂����B
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------




:===========================================================================================================================================

:w2xco_file

call wtb.bat START
:�t�@�C����
echo %~n1 >>%logname%.log 2>>&1
echo %~x1 >>%logname%.log 2>>&1
echo %~p1 >>%logname%.log 2>>&1
if "%mode01%" == "auto_scale" goto nam_autoo
if "%mode01%" == "noise_scale" goto nam_ao
if "%mode01%" == "noise" goto nam_bo
if "%mode01%" == "scale" goto nam_co

:nam_autoo
if /I "%~x1" == ".jpg" (
 goto nam_ao
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_ao
 ) else (
 goto nam_co
 )
 
:nam_ao
set mode01nam=%~n1_waifu2x-converter-cpp-%mode01%-Lv%noise_level01%-%scale_ratio01%x%~x1
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:nam_bo

set mode01nam=%~n1_waifu2x-converter-cpp-noise-Lv%noise_level01%%~x1
set mode01var=-m noise --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:nam_co

set mode01nam=%~n1_waifu2x-converter-cpp-%mode01%-%scale_ratio01%x%~x1
set mode01var=-m scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:EONamo

if "%~1" == "" goto Finish_w2x


echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�...

%usewaifu% --model_dir ".\models\%model01%" %mode01var% -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\%mode01nam%" %otheropco01% >>%logname%.log 2>>&1


set w2xcERROR=%ERRORLEVEL%

if "%w2xcERROR%" GEQ "1" (
 echo �G���[ >>%logname%.log 2>>&1
 echo �G���[
 ) else (
 echo %DATE% %TIME% "%~1"�̕ϊ���Ƃ�����ɏI�����܂����B�����摜��:%mode01nam% >>%logname%.log 2>>&1
 echo %DATE% %TIME% "%~1"�̕ϊ���Ƃ�����ɏI�����܂����B�����摜��:%mode01nam%
 )
 call wtb.bat STOP
 echo "%~1"�ϊ����� >>%logname%.log 2>>&1
 call wtb.bat PRINT >>%logname%.log 2>>&1
 echo "%~1"�ϊ�����
 call wtb.bat PRINT
 shift
 pushd %~1
 if Errorlevel 1 (
 goto w2xco_file
 ) else (
 popd
 goto restart
 )
:===========================================================================================================================================
:w2xca_file
call wtb.bat START
:�t�@�C����

if "%mode01%" == "auto_scale" goto nam_autoa
if "%mode01%" == "noise_scale" goto nam_aa
if "%mode01%" == "noise" goto nam_ba
if "%mode01%" == "scale" goto nam_ca

:nam_autoa
if /I "%~x1" == ".jpg" (
 goto nam_aa
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_aa
 ) else (
 goto nam_ca
 )
 
:nam_aa
set mode01nam=%~n1_waifu2x-caffe-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONama

:nam_ba

set mode01nam=%~n1_waifu2x-caffe-%mode01%-Lv%noise_level01%.%out_ext01%
set mode01var=-m noise --noise_level %noise_level01%
goto EONama

:nam_ca

set mode01nam=%~n1_waifu2x-caffe-%mode01%-%scale_ratio01%x.%out_ext01%
set mode01var=-m scale --noise_level --scale_ratio %scale_ratio01%
goto EONama

:EONama

if "%~1" == "" goto Finish_w2x


echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�...

waifu2x-caffe-cui -p %process01% --model_dir ".\models\%model01%" %mode01var% -i %~1 -o "%~dp1\%outfolder%\%mode01nam%" %otheropca01% >>%logname%.log 2>>&1

set w2xcERROR=%ERRORLEVEL%

if "%w2xcERROR%" GEQ "1" (
 if "%process01%" == "gpu" (
  set usewaifu=waifu2x-converter_x64
  echo %DATE% %TIME% Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bconverter�Ɉڂ����̑��̃n�[�h�ł̕ϊ����J�n���܂��B >>%logname%.log 2>>&1
  echo %DATE% %TIME% Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bconverter�Ɉڂ����̑��̃n�[�h�ł̕ϊ����J�n���܂��B
  goto w2xco_file
  ) else (
  echo Error! >>%logname%.log 2>>&1
  echo Error!
  )
 ) else (
 echo %DATE% %TIME% "%~1"�̕ϊ���Ƃ�����ɏI�����܂����B�����摜��:%mode01nam% >>%logname%.log 2>>&1
 echo %DATE% %TIME% "%~1"�̕ϊ���Ƃ�����ɏI�����܂����B�����摜��:%mode01nam%
  call wtb.bat STOP
 echo "%~1"�ϊ����� >>%logname%.log 2>>&1
 call wtb.bat PRINT >>%logname%.log 2>>&1
 echo "%~1"�ϊ�����
 call wtb.bat PRINT
 shift
 pushd %~1
 if Errorlevel 1 (
 goto w2xca_file
 ) else (
 popd
 goto restart
 )
 )

:===========================================================================================================================================
:w2xco_folder
set 1="%foldernamevar%"
pushd %~dpn1
set hoge=*.%inexli01::= *.%
echo %hoge% 
if "%subf01%" == "true" (
 echo �T�u�t�H���_�������[�h >>%logname%.log 2>>&1
 for /R %%t in (%hoge%) do call :w2xcof1 "%%~t"
 ) else (
 for %%t in (%hoge%) do call :w2xcof1 "%~dpn1\%%~t"
 )
if not "%~1" == "" (
 shift
 goto restart
 )
goto  Finish_w2x



:w2xcof1
popd
set cafname=%~n1
if not "!cafname:waifu2x=hoge!" == "!cafname!" exit /b >>%logname%.log 2>>&1

mkdir %~dp1\%outfolder%

call wtb.bat START

:�t�@�C����

if "%mode01%" == "auto_scale" goto nam_autof
if "%mode01%" == "noise_scale" goto nam_af
if "%mode01%" == "noise" goto nam_bf
if "%mode01%" == "scale" goto nam_cf

:nam_autof
if /I "%~x1" == ".jpg" (
 goto nam_af
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_af
 ) else (
 goto nam_cf
 )
 
:nam_af
set mode01nam=%~n1_waifu2x-converter-cpp-noise_scale-Lv%noise_level01%-%scale_ratio01%x%~x1
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:nam_bf

set mode01nam=%~n1_waifu2x-converter-cpp-noise-Lv%noise_level01%%~x1
set mode01var=-m noise --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:nam_cf

set mode01nam=%~n1_waifu2x-converter-cpp-scale-%scale_ratio01%x%~x1
set mode01var=-m scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:EONamf
echo.
echo. >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�...

%usewaifu% --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\!mode01nam!" %otheropco01% >>%logname%.log 2>>&1


set w2xcERROR=!ERRORLEVEL!

if "!w2xcERROR!" GEQ "1" (
 echo �G���[ >>%logname%.log 2>>&1
 echo �G���[
 ) else (
 echo !DATE! !TIME! "%~1"�̕ϊ���Ƃ�����ɏI�����܂����B�����摜��:!mode01nam! >>%logname%.log 2>>&1
 echo !DATE! !TIME! "%~1"�̕ϊ���Ƃ�����ɏI�����܂����B�����摜��:!mode01nam!
 )
 call wtb.bat STOP
 echo "%~1"�ϊ����� >>%logname%.log 2>>&1
 call wtb.bat PRINT >>%logname%.log 2>>&1
 echo "%~1"�ϊ�����
 call wtb.bat PRINT


exit /b
 
:===========================================================================================================================================
:w2xca_folder
set 1="%foldernamevar%"
pushd %~dpn1
set hoge=*.%inexli01::= *.%
echo %hoge% 
if "%subf01%" == "true" (
 for /R %%t in (%hoge%) do call :w2xcaf1 "%%~t"
 ) else (
 for %%t in (%hoge%) do call :w2xcaf1 "%~dpn1\%%~t"
 )
if "%w2xcERROR%" GEQ "1" (
 set usewaifu=waifu2x-converter_x64
 echo !DATE! !TIME! Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bconverter�Ɉڂ����̑��̃n�[�h�ł̕ϊ����J�n���܂��B >>%logname%.log 2>>&1
 echo !DATE! !TIME! Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bconverter�Ɉڂ����̑��̃n�[�h�ł̕ϊ����J�n���܂��B
 goto w2xco_folder
)
shift
if not "%~1" == "" (
 shift
 goto restart
 )
goto  Finish_w2x



:w2xcaf1
popd
set cafname=%~n1
if not "!cafname:waifu2x=hoge!" == "!cafname!" exit /b >>%logname%.log 2>>&1
mkdir %~dp1\%outfolder%

call wtb.bat START

:�t�@�C����

if "%mode01%" == "auto_scale" goto nam_autofa
if "%mode01%" == "noise_scale" goto nam_afa
if "%mode01%" == "noise" goto nam_bfa
if "%mode01%" == "scale" goto nam_cfa

:nam_autofa
if /I "%~x1" == ".jpg" (
 goto nam_afa
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_afa
 ) else (
 goto nam_cfa
 )
 
:nam_afa
set mode01nam=%~n1_waifu2x-caffe-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamfa

:nam_bfa

set mode01nam=%~n1_waifu2x-caffe-%mode01%-Lv%noise_level01%.%out_ext01%
set mode01var=-m noise --noise_level %noise_level01%
goto EONamfa

:nam_cfa

set mode01nam=%~n1_waifu2x-caffe-%mode01%-%scale_ratio01%x.%out_ext01%
set mode01var=-m scale --scale_ratio %scale_ratio01%
goto EONamfa

:EONamfa
echo.
echo. >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�...

waifu2x-caffe-cui -p !process01! --model_dir ".\models\%model01%" %mode01var% -i "%~1" -o "%~dp1\%outfolder%\!mode01nam!" %otheropca01% >>%logname%.log 2>>&1

set w2xcERROR=!ERRORLEVEL!

if "!w2xcERROR!" GEQ "1" (
 exit /b
 )
 echo !DATE! !TIME! "%~1"�̕ϊ���Ƃ�����ɏI�����܂����B�����摜��:!mode01nam! >>%logname%.log 2>>&1
 echo !DATE! !TIME! "%~1"�̕ϊ���Ƃ�����ɏI�����܂����B�����摜��:!mode01nam!
 call wtb.bat STOP
 echo "%~1"�ϊ����� >>%logname%.log 2>>&1
 call wtb.bat PRINT >>%logname%.log 2>>&1
 echo "%~1"�ϊ�����
 call wtb.bat PRINT


exit /b
 
:===========================================================================================================================================

:Finish_w2x



echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------
echo %DATE% %TIME% Finish waifu2x-converter.bat >>%logname%.log 2>>&1
echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B >>%logname%.log 2>>&1

echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B
call wta.bat STOP
echo waifu2x-converter.bat���s���� >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1

echo waifu2x-converter.bat���s����
call wta.bat PRINT

echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1
echo ------------------------------------------- >>%logname%.log 2>>&1
echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1

pause
:end