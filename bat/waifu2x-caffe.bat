@echo off
:=============================================================
:#############################################################
:�ݒ�
:#############################################################
: �ݒ���@
:set xx01=[���[�h]���[�����Ƃ͍l����=�̌������������Ă�������
:Don't think. Please feel.
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

set model01=photo

: anime_style_art (�񎟉摜 �P�x�̂�)
: anime_style_art_rgb (�񎟉摜 RGB��)
: photo (�ʐ^)
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

set noise_level01=2

: 1,2,super �ǂ��炩��I��
: 1�̂ق��������ʂ����Ȃ������ɒ���
: super��0.9�̂߂��Ⴍ���ይ�͂ȃ��f���ł��B
: super��photo�ł��p�ӂ���Ă��܂���B
:=============================================================
:
:�ϊ�����g���q[-l --input_extention_list]
:

set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga

: ��؂蕶���� " : "(�R����)�B�Ō�ɂ͂��Ȃ�
: �啶����������ʂȂ�
:=============================================================
:
:�o�͊g���q[-e --output_extention]
:

set out_ext01=png

: �w�肵�Ȃ��ꍇ�͋�(=�̎��͉��s)�ɂ���B �X�y�[�X�������
: �f�t�H���g��png�B" . "(�h�b�g)�����Ȃ�
: �w��ł���͈̂�ł�(����bat�̎d�l�ł�)
:=============================================================
:
:�t�H���_����������Ƃ��T�u�t�H���_����������[bat�Ǝ�]
:Recursion[This batch's own mode]
:

set subf01=true

: true/false(�L��/����)
:=============================================================
:
:�o�̓t�H���_��[bat�Ǝ�]
:Output folder name[This batch's own mode]
:

set outfolder=waifued

:����Ȑ[�����Ƃ͍l����waifued�Ɩ��t���܂���������ϕς���
:����Ȃ��̂ŕύX�ł���悤�ɂ��Ă݂���
:
:�󔒂ɂ���Γ����t�H���_�ɏo�͂ł���񂶂�Ȃ����Ǝv��
:=============================================================
:
:�g�p����waifu2x[bat�Ǝ�]
:Which do you use cpp or caffe?[This batch's own mode]
:

set usewaifu=waifu2x-caffe-cui

:�g�p����waifu2x��I�����܂��B
:
: waifu2x-converter_x64 (cpp64bit)
: waifu2x-converter     (cpp32bit/64bit�����I��)
: waifu2x-caffe-cui     (caffe)
:
:��L�ȊO����͂���ƃG���[��f���܂��B
:���������Ȃ��ƁA�����I�ɔ��f���܂��B
:=============================================================
:
:���̑��I�v�V����(�㋉�җp�ݒ�)
:
:          ��ca(��)��caffe co(��)��converter-cpp
set otheropca01=
set otheropco01=

:�Ȃɂ��������Ŏw�肵�����I�v�V����������Ύw�肵�Ă��������B
:�R�}���h�v�����v�g�őł����ތ`�ŋL�����Ă��������B
:=============================================================
:�����̌v�Z�ɂ��Ή��������Ȃ��Ƃ��v������
:#############################################################
:������
:#############################################################
:�E�o�͉摜����
: [���摜��]_waifu2xco-[�������[�h]-[���f��]-Lv[�m�C�YLv]-[�g�嗦]x.jpg
:  �ƂȂ�܂��B
:
:�i��j
:�@�@waifu2xco-noise_scale-photo-Lv1-4x_motogazounonamae.jpg
:
:
:���̉����珈���p�̃v���O�������n�܂�܂��B
:=============================================================















































:===========================================================================================================================================
:����
setlocal enabledelayedexpansion
set firstprocess=true
set process01=gpu
set hoge=*.%inexli01::= *.%

@pushd %~1
set pushderrorlv=%ErrorLevel%
if "%pushderrorlv%" GEQ "1" (
 goto s_file
) else (
 popd
 goto s_folder
)


:s_file

mkdir "%~dp1\%outfolder%"
set logname=%~dp1\%outfolder%\w2xresult
echo %DATE% %TIME% Run %~nx0 >>"%logname%.log" 2>>&1
echo %DATE% %TIME% "%~dp1\%outfolder%"���쐬(���łɂ���ꍇ���̎|��������Ă��܂�)
echo %DATE% %TIME% "%logname%.log"���쐬(���łɂ���ꍇ�͒ǋL���܂��B)
cd /d %~dp0 >>"%logname%.log" 2>>&1
cd .. >>"%logname%.log" 2>>&1
goto next1

:s_folder

mkdir "%~dpn1\%outfolder%"
set logname=%~dpn1\%outfolder%\w2xresult
echo %DATE% %TIME% Run %~nx0 >>"%logname%.log" 2>>&1
echo %DATE% %TIME% "%~dpn1\%outfolder%"���쐬(���łɂ���ꍇ���̎|��������Ă��܂�)
echo %DATE% %TIME% "%logname%.log"���쐬(���łɂ���ꍇ�͒ǋL���܂��B)
cd /d "%~dp0" >>"%logname%.log" 2>>&1
cd .. >>"%logname%.log" 2>>&1


:next1
call wta.bat START

:super����
if "%noise_level01%" == "super" (
 if "%model01%" == "photo" (
 echo photo���f���ł�super���g���܂���Banime_style_art_rgb���f���ŏ������܂��B
 echo photo���f���ł�super���g���܂���Banime_style_art_rgb���f���ŏ������܂��B >>"%logname%.log" 2>>&1
 set model01=super-anime_style_art_rgb
 set noise_level01=2
 ) else if not "%model01:anime_style_art=hoge%" == "%model01%" (
 set model01=super-%model01%
 set noise_level01=2
 )
)


:���[�h�ݒ�
if "%usewaifu%" == "" (
  if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
  
 set usewaifu=waifu2x-caffe-cui
 set autochoosecc=step1
 echo %DATE% %TIME% 64bitCPU�����o���܂����B�͂��߂�waifu2x-caffe�ŏ������܂��B
 echo %DATE% %TIME% 64bitCPU�����o���܂����B�͂��߂�waifu2x-caffe�ŏ������܂��B >>"%logname%.log" 2>>&1
 goto shiwake
  ) else (
 set usewaifu=waifu2x-converter
 echo %DATE% %TIME% 32bitCPU�����o���܂����B32bit��waifu2x-converter�ŏ������܂��B
 echo %DATE% %TIME% 32bitCPU�����o���܂����B32bit��waifu2x-converter�ŏ������܂��B >>"%logname%.log" 2>>&1
 goto shiwake
  )
 ) else if "%usewaifu%" == "waifu2x-converter" (
   if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
   set usewaifu=waifu2x-converter_x64
   )
  goto shiwake
 ) else (
 goto shiwake
 )
:===========================================================================================================================================
:shiwake
@pushd "%~1"
set pushderrorlv=%ErrorLevel%
if "%pushderrorlv%" GEQ "1" (
 set folder=false
 if "%~x1" == "" (
 echo Error�I�I�I >>"%logname%.log" 2>>&1
 echo Error�I�I�I
 echo �����ꂩ�̃t�@�C���̖��O�ɏ����ł��Ȃ��������܂܂�Ă���悤�ł��B^;��^,���Ȃ����m�F���Ă��������B >>"%logname%.log" 2>>&1
 echo �����ꂩ�̃t�@�C���̖��O�ɏ����ł��Ȃ��������܂܂�Ă���悤�ł��B^;��^,���Ȃ����m�F���Ă��������B
 goto Finish_w2x
 )
) else (
 popd
 set folder=true
)

if "%folder%" == "true" (
 goto w2x_folder
 ) else if "%folder%" == "false" (
 goto w2x_file
 ) else (
 echo Error�I�I�I >>"%logname%.log" 2>>&1
 echo Error�I�I�I
 goto Finish_w2x
 )
 

:===========================================================================================================================================


:namer
if "%out_ext01%" NEQ "" (
 set exte=.%out_ext01%
 ) else (
 set exte=%~x1
 )
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
set mode01nam=%~n1_waifu2x-noise_scale-%model01%-Lv%noise_level01%-%scale_ratio01%x!exte!
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONam

:nam_b

set mode01nam=%~n1_waifu2x-noise-%model01%-Lv%noise_level01%!exte!
set mode01var=-m noise --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONam

:nam_c

set mode01nam=%~n1_waifu2x-scale-%model01%-%scale_ratio01%x!exte!
set mode01var=-m scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONam

:EONam
goto end
:===========================================================================================================================================

:dow2x

call wtb.bat START

call :namer "%~1"

echo.
echo. >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�... >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�...


if "!usewaifu:converter=!" NEQ "!usewaifu!" (
!usewaifu! --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\%outfolder%\!mode01nam!" %otheropco01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
!usewaifu! -p !process01! --model_dir ".\models\%model01%" !mode01var! -i "%~1" -o "%~dp1\%outfolder%\!mode01nam!" -l %inexli01% -e %ex:~1% %otheropca01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else (
echo Error�I�I�I 0x00 >>"%logname%.log" 2>>&1
echo Error�I�I�I 0x00
exit /b
)

if "!w2xERROR!" GEQ "1" (
 if "!autochoosecc!" == "step1" (
  set usewaifu=waifu2x-converter_x64
  set autochoosecc=step2
  echo !DATE! !TIME! caffe��GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bconverter�Ɉڂ����̑��̃n�[�h�ł̕ϊ����J�n���܂��B >>"%logname%.log" 2>>&1
  echo !DATE! !TIME! caffe��GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bconverter�Ɉڂ����̑��̃n�[�h�ł̕ϊ����J�n���܂��B
  goto dow2x
 ) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
  if "!process01!" == "gpu" (
  set process01=cpu
  echo !DATE! !TIME! caffe��GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bcpu�ŕϊ����܂��B >>"%logname%.log" 2>>&1
  echo !DATE! !TIME! caffe��GPU�ł̕ϊ������݂܂������A�ł��܂���ł����Bcpu�ŕϊ����܂��B
  goto dow2x
  ) else (
  echo Error�I�I�I 0x01 >>"%logname%.log" 2>>&1
  echo Error�I�I�I 0x01
  exit /b
  )
 ) else (
  echo Error�I�I�I 0x02 >>"%logname%.log" 2>>&1
  echo Error�I�I�I 0x02
  exit /b
 )
 ) else (
 echo !DATE! !TIME! "%~nx1"�̕ϊ���Ƃ�����ɏI�����܂����B >>"%logname%.log" 2>>&1
 echo �����摜��:!mode01nam! >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! "%~nx1"�̕ϊ���Ƃ�����ɏI�����܂����B
 echo �����摜��:!mode01nam!
 )
 call wtb.bat STOP
 echo "%~1"�ϊ����� >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo "%~1"�ϊ�����
 call wtb.bat PRINT

goto end

:===========================================================================================================================================

:w2x_file
call wtb.bat START

:inexli01�ɂ����Ă邩�m�F����
setlocal
set ex=%~x1
set n=0
for %%a in (%inexli01::= %) do (
if /I "%ex%" == ".%%a" set excheckr=true
)

if "!excheckr!" == "true" (
 endlocal
 goto okayex
 ) else (
endlocal

 echo "%~nx1"��ǂݍ��݂܂������A�o�b�`�t�@�C���Ŏw�肳�ꂽ�g���q�̒���"%~x1"���Ȃ��������ߕϊ����܂���B >>"%logname%.log" 2>>&1
 echo "%~nx1"��ǂݍ��݂܂������A�o�b�`�t�@�C���Ŏw�肳�ꂽ�g���q�̒���"%~x1"���Ȃ��������ߕϊ����܂���B
 goto nextforex
 )
:okayex

call :dow2x "%~1"

:nextforex
 shift
 if "%~1" == "" goto Finish_w2x
 goto shiwake
 
:===========================================================================================================================================
:w2x_folder
@pushd "%~dpn1"

echo %DATE% %TIME% "%~1"�̏������J�n���܂�...[�t�H���_���[�h]
if "%subf01%" == "true" (
 echo �T�u�t�H���_�������[�h >>"%logname%.log" 2>>&1
 for /R %%t in (%hoge%) do call :w2xf1 "%%~t"
 ) else (
 for %%t in (%hoge%) do call :w2xf1 "%~dpn1\%%~t"
 )
shift
if "%~1" == "" goto Finish_w2x
goto shiwake
 
:w2xf1
popd

set cafname=%~n1
if not "!cafname:waifu2x=hoge!" == "!cafname!" exit /b >>"%logname%.log" 2>>&1

mkdir "%~dp1\%outfolder%"

call :dow2x "%~1"

goto end
:===========================================================================================================================================

:Finish_w2x
echo ------------------------------------------- >>"%logname%.log" 2>>&1
echo -------------------------------------------
echo Finish: %~nx0 >>"%logname%.log" 2>>&1
echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B >>"%logname%.log" 2>>&1

echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B
call wta.bat STOP
call wta.bat PRINT >>"%logname%.log" 2>>&1
call wta.bat PRINT

echo ------------------------------------------- >>"%logname%.log" 2>>&1
echo ------------------------------------------- >>"%logname%.log" 2>>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
pause
exit
:end