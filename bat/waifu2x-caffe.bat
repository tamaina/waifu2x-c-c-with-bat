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
:�t�H���_���̕ϊ�����g���q[-l --input_extention_list]
:

set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga

: ��؂蕶���� " : "(�R����) �Ō�ɂ͂��Ȃ�
: �啶����������ʂȂ�
:=============================================================
:
:�o�͊g���q[-e --output_extention]
:

set out_ext01=png

: �f�t�H���g��png
: �w��ł���͈̂�ł�(����bat�̎d�l�ł�)
:=============================================================
:
:�T�u�t�H���_����������[bat�Ǝ�]
:

set subf01=true

: true/false(�L��/����)
: �T�u�t�H���_�̒��g�̓T�u�t�H���_�̂Ȃ���
:=============================================================
:
:�o�̓t�H���_��[bat�Ǝ�]
:

set outfolder=waifucaed


:����Ȑ[�����Ƃ͍l����waifued�Ɩ��t���܂���������ϕς���
:����Ȃ��̂ŕύX�ł���悤�ɂ��Ă݂���
:=============================================================
:
:�v���Z�b�T�w��[-p --process]
:

set process01=gpu

: cpu
: gpu
: cudnn
: gpu���w�肵���ꍇ�A���s����Ǝ����I��cpu�ł̏����Ɉڍs���܂�
:=============================================================
:
:���̑��I�v�V����(�㋉�җp�ݒ�)
:

set otheropca01=

:�Ȃɂ��������Ŏw�肵�����I�v�V����������Ύw�肵�Ă��������B
:�R�}���h�v�����v�g�őł����ތ`�ŋL�����Ă��������B
:=============================================================
:�����̌v�Z�ɂ��Ή��������Ȃ��Ƃ��v������
:#############################################################
:������
:#############################################################
:�E�o�͉摜����
: [���摜��]_waifu2xca-[�������[�h]-Lv[�m�C�YLv]-[�g�嗦]x.jpg
:  �ƂȂ�܂��B
:
:�i��j
:�@�@waifu2xca-noise_scale-Lv1-4x_asoboy.jpg
:
:
:���̉����珈���p�̃v���O�������n�܂�܂��B
:=============================================================














































:����
setlocal enabledelayedexpansion
set firstprocess=true
set datcdd=%~d0
set datcdp=%~p0
set datcdn=%~n0
goto ffjudge

:restart
if "%~1" == "" goto Finish_w2xco
set firstprocess=false

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
if "%firstprocess%" == "true" (
 goto next1
 ) else (
 goto w2xca_file
 )

:s_folder

mkdir %~dpn1\%outfolder%
set logname=%~dpn1\%outfolder%\w2xresult
echo %DATE% %TIME% �t�H���_���[�h
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [�t�H���_���[�h] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dpn1\%outfolder%"���쐬
echo %DATE% %TIME% "%logname%.log"���쐬(���łɂ���ꍇ�͒ǋL���܂��B)
cd /d %datcdd%%datcdp% >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
if "%firstprocess%" == "true" (
 goto next1
 ) else (
 goto w2xca_folder
 )


:next1
call wta.bat START

:CPU���o

if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
 echo %DATE% %TIME% 64bitCPU���m�F���܂����B
 echo %DATE% %TIME% 64bitCPU���m�F���܂����B>>%logname%.log 2>>&1
 ) else (
 set usewaifu=waifu2x-converter
 echo %DATE% %TIME% ���g����CPU��32bit�ł��Bwaifu2x-caffe��32bitCPU�ł͎g���܂���Bwaifu2x-converter�����g�����������B
 echo %DATE% %TIME% ���g����CPU��32bit�ł��Bwaifu2x-caffe��32bitCPU�ł͎g���܂���Bwaifu2x-converter�����g�����������B >>%logname%.log 2>>&1
 echo �I������ɂ͉����L�[�������Ă��������B
 pause > NUL
 exit
 )


:�n���ϐ�(���[�h�֌W)

set mode01var=-m %mode01% --noise_level %noise_level01% --scale_ratio %scale_ratio01% -l %inexli01% -e %out_ext01%
echo %DATE% %TIME% �����������������܂����B >>%logname%.log 2>>&1
echo %DATE% %TIME% �����������������܂����B
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------


if "%folder%" == "true" (
 echo %DATE% %TIME% �t�H���_���[�h >>%logname%.log 2>>&1
 echo %DATE% %TIME% �t�H���_���[�h
 goto w2xca_folder
 ) else (
 echo %DATE% %TIME% �t�@�C�����[�h >>%logname%.log 2>>&1
 echo %DATE% %TIME% �t�@�C�����[�h
 goto w2xca_file
 )

:===========================================================================================================================================

:w2xca_file
call wtb.bat START
:�t�@�C����

if "%mode01%" == "auto_scale" goto nam_auto
if "%mode01%" == "noise_scale" goto nam_a
if "%mode01%" == "noise" goto nam_b
if "%mode01%" == "scale" goto nam_c

:nam_auto
if /I "%~x1" == ".jpg" (
 goto nam_a
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_a
 ) else (
 goto nam_c
 )
 
:nam_a
set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
goto EONam

:nam_b

set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%.%out_ext01%
goto EONam

:nam_c

set mode01nam=%~n1_waifu2x-%mode01%-%scale_ratio01%x.%out_ext01%
goto EONam

:EONam

if "%~1" == "" goto Finish_w2xca


echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�...

waifu2x-caffe-cui -p %process01% --model_dir ".\models\%model01%" %mode01var% -i "%~1" -o "%~dp1\%outfolder%\%mode01nam%" >>%logname%.log 2>>&1

set w2xcERROR=%ERRORLEVEL%

if "%w2xcERROR%" GEQ "1" (
 if "%process01%" == "gpu" (
  set process01=cpu
  echo %DATE% %TIME% Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����BCPU�ł̕ϊ����J�n���܂��B >>%logname%.log 2>>&1
  echo %DATE% %TIME% Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����BCPU�ł̕ϊ����J�n���܂��B
  goto EONam
  ) else (
  echo %DATE% %TIME% CPU�ŏ������܂������A�G���[���������ĕϊ��ł��܂���ł����B >>%logname%.log 2>>&1
  echo %DATE% %TIME% CPU�ŏ������܂������A�G���[���������ĕϊ��ł��܂���ł����B
  echo �I������ɂ͉����L�[�������Ă��������B
  pause > NUL
  exit
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
:w2xca_folder
pushd %~dpn1
set hoge=*.%inexli01::= *.%
echo %hoge% 
if "%subf01%" == "true" (
 for /R %%t in (%hoge%) do call :w2xcaf1 "%%~t"
 ) else (
 for %%t in (%hoge%) do call :w2xcaf1 "%~dpn1\%%~t"
 )
if not "%~1" == "" (
 shift
 goto restart
 )

goto  Finish_w2xca



:w2xcaf1
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
set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
goto EONamf

:nam_bf

set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%.%out_ext01%
goto EONamf

:nam_cf

set mode01nam=%~n1_waifu2x-%mode01%-%scale_ratio01%x.%out_ext01%
goto EONamf

:EONamf
echo.
echo. >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�...

waifu2x-caffe-cui -p !process01! --model_dir ".\models\%model01%" %mode01var% -i "%~1" -o "%~dp1\%outfolder%\!mode01nam!" >>%logname%.log 2>>&1

set w2xcERROR=!ERRORLEVEL!

if "!w2xcERROR!" GEQ "1" (
 if "!process01!" == "gpu" (
  set process01=cpu
  echo !DATE! !TIME! Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����BCPU�ł̕ϊ����J�n���܂��B >>%logname%.log 2>>&1
  echo !DATE! !TIME! Nvidia GPU�ł̕ϊ������݂܂������A�ł��܂���ł����BCPU�ł̕ϊ����J�n���܂��B
  goto EONamf
  ) else (
  echo !DATE! !TIME! CPU�ŏ������܂������A�G���[���������ĕϊ��ł��܂���ł����B >>%logname%.log 2>>&1
  echo !DATE! !TIME! CPU�ŏ������܂������A�G���[���������ĕϊ��ł��܂���ł����B
  echo �I������ɂ͉����L�[�������Ă��������B
  pause > NUL
  exit
  )
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

:Finish_w2xca



echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------
echo %DATE% %TIME% Finish waifu2x-caffe.bat >>%logname%.log 2>>&1
echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B >>%logname%.log 2>>&1

echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B
call wta.bat STOP
echo waifu2x-caffe.bat���s���� >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1

echo waifu2x-caffe.bat���s����
call wta.bat PRINT

echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1
echo ------------------------------------------- >>%logname%.log 2>>&1
echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1

pause
:end