@echo off
:=============================================================
:#############################################################
:�ݒ�
:#############################################################
: �ݒ���@
:set xx01=[���[�h]���[�����Ƃ͍l����=�̌������������Ă�������
:=============================================================
:
:���샂�[�h[-m --mode]
:

set mode01=auto_scale

: auto_scale(�g��Ejpeg�Ȃ�m�C�Y����������)
: noise_scale(�m�C�Y�����E�g��)
: noise(�m�C�Y����)
: scale(�g��)
:=============================================================
:
:���f���I��[--model_dir]
:

set model01=anime_style_art_rgb

: anime_style_art(�񎟉摜 �P�x�̂�)
: anime_style_art_rgb(�񎟉摜 RGB��)
: photo(�ʐ^)
:=============================================================
:
:�g�嗦[--scale_ratio]
:

set scale_ratio01=2

: ����(�P�� �{)�����_��
:=============================================================
:
:�m�C�Y�������x��[--noise_level]
:

set noise_level01=1

: 1,2 �ǂ��炩��I��
: 1�̂ق��������ʂ����Ȃ������ɒ���
:=============================================================
:
:�T�u�t�H���_����������[bat�Ǝ�]
:

set subf01=true

: true/false(�L��/����)
:=============================================================
:
:�o�̓t�H���_��[bat�Ǝ�]
:

set outfolder=waifued


:����Ȑ[�����Ƃ͍l����waifued�Ɩ��t���܂���������ϕς���
:����Ȃ��̂ŕύX�ł���悤�ɂ��Ă݂���
:=============================================================
:
:�t�H���_���̕ϊ�����g���q[bat�Ǝ�?]
:

set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga

: ��؂蕶���� " : "(�R����) �Ō�ɂ͂��Ȃ�
: �啶����������ʂȂ�
:*�{��caffe��[-l --input_extention_list]�̎d�l����bat������
: �ł��Ă��܂����̂�converter�ł�������Ȃ����p�ł���B
:=============================================================
:��caffe�ł����Ŏg�p����I�v�V����
:#############################################################
:
:�o�͊g���q[-e --output_extention]
:

set out_ext01=png

: �f�t�H���g��png
: �w��ł���͈̂�ł�(����bat�̎d�l�ł�)
:=============================================================
:�����̌v�Z�ɂ��Ή��������Ȃ��Ƃ��v������
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
:���̉����珈���p�̃v���O�������n�܂�܂��B
:=============================================================














































:����
setlocal enabledelayedexpansion
set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga
set process01=gpu
pushd %~1
if Errorlevel 1 (
 set folder=false
 goto s_file
) else (
 popd
 set folder=true
 goto s_folder
)


:s_file
set datcdd=%~d0
set datcdp=%~p0
set datcdn=%~n0

mkdir %~dp1\%outfolder%
set logname=%~dp1\%outfolder%\result
echo %DATE% %TIME% �t�@�C�����[�h
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [�t�@�C�����[�h] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dp1\%outfolder%"���쐬
echo %DATE% %TIME% "%logname%.log"���쐬(���łɂ���ꍇ�͒ǋL���܂��B)
cd /d %~dp0 >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
goto next1

:s_folder
set datcdd=%~d0
set datcdp=%~p0
set datcdn=%~n0
set foldernamevar=%~1
mkdir %~dpn1\%outfolder%
set logname=%~dpn1\%outfolder%\result
echo %DATE% %TIME% �t�H���_���[�h
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [�t�H���_���[�h] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dpn1\%outfolder%"���쐬
echo %DATE% %TIME% "%logname%.log"���쐬(���łɂ���ꍇ�͒ǋL���܂��B)
cd /d %~dp0 >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1


:next1
call wta.bat START



:CPU���o
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
 set usewaifu=waifu2x-converter_x64
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
 ) else (
 set usewaifu=waifu2x-converter
 echo %DATE% %TIME% 32bitCPU�����o���܂����B32bit��waifu2x-converter�ŏ������܂��B
 echo %DATE% %TIME% 32bitCPU�����o���܂����B32bit��waifu2x-converter�ŏ������܂��B >>%logname%.log 2>>&1
 )


echo %DATE% %TIME% �����������������܂����B >>%logname%.log 2>>&1
echo %DATE% %TIME% �����������������܂����B
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------




:===========================================================================================================================================

:w2xco_file
call wtb.bat START
:�t�@�C����

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
set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%-%scale_ratio01%x%~x1
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:nam_bo

set mode01nam=%~n1_waifu2x-noise-Lv%noise_level01%%~x1
set mode01var=-m noise --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:nam_co

set mode01nam=%~n1_waifu2x-%mode01%-%scale_ratio01%x%~x1
set mode01var=-m scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:EONamo

if "%~1" == "" goto Finish_w2x


echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�...

%usewaifu% --model_dir ".\models\%model01%" %mode01var% -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\%mode01nam%" >>%logname%.log 2>>&1


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
 goto EONamo
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
set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
goto EONama

:nam_ba

set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%.%out_ext01%
goto EONama

:nam_ca

set mode01nam=%~n1_waifu2x-%mode01%-%scale_ratio01%x.%out_ext01%
goto EONama

:EONama

if "%~1" == "" goto Finish_w2x


echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�...

waifu2x-caffe-cui -p %process01% --model_dir ".\models\%model01%" %mode01var% -i "%~1" -o "%~dp1\%outfolder%\%mode01nam%" >>%logname%.log 2>>&1

set w2xcERROR=%ERRORLEVEL%

if "%w2xcERROR%" GEQ "1" (
 if "%process01%" == "gpu" (
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
 goto EONama
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
 goto w2xco_folder
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
set mode01nam=%~n1_waifu2x-noise_scale-Lv%noise_level01%-%scale_ratio01%x%~x1
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:nam_bf

set mode01nam=%~n1_waifu2x-noise-Lv%noise_level01%%~x1
set mode01var=-m noise --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:nam_cf

set mode01nam=%~n1_waifu2x-scale-%scale_ratio01%x%~x1
set mode01var=-m scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:EONamf
echo.
echo. >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�...

%usewaifu% --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\!mode01nam!" >>%logname%.log 2>>&1


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
 echo !DATE! !TIME! Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bconverter�Ɉڂ����̑��̃n�[�h�ł̕ϊ����J�n���܂��B >>%logname%.log 2>>&1
 echo !DATE! !TIME! Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bconverter�Ɉڂ����̑��̃n�[�h�ł̕ϊ����J�n���܂��B
 goto w2xco_folder
)
shift
if not "%~1" == "" (
 shift
 goto w2xca_folder
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
set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
goto EONamfa

:nam_bfa

set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%.%out_ext01%
goto EONamfa

:nam_cfa

set mode01nam=%~n1_waifu2x-%mode01%-%scale_ratio01%x.%out_ext01%
goto EONamfa

:EONamfa
echo.
echo. >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�...

waifu2x-caffe-cui -p !process01! --model_dir ".\models\%model01%" %mode01var% -i "%~1" -o "%~dp1\%outfolder%\!mode01nam!" >>%logname%.log 2>>&1

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