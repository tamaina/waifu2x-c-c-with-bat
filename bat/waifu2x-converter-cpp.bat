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
:�g�嗦(+�����ݒ�)[--scale_ratio]+[bat�Ǝ�]
:About "scale_ratio"
:
:************************************************************
:�y�@�z�����{���v�Z���[�hon/off
:Auto Calculate Magnification

set scaleauto=false

:�g�嗦�������Ōv�Z���Ă��ׂẲ摜�̕��܂��͍��������낦�܂��B
:true(�L��)/false(����)
:
:�L���ɂ���ꍇ�AImageMagic���K�v�ł��B
:
:true�ɂ����ꍇ�A�K���A�B�̐ݒ�����Ă��������B
:false�ɂ����ꍇ�A�C�̐ݒ肪�K�p����܂��B
:
:************************************************************
:�y�A�z�ڕW��
:Target Width

set scaleauto_width01=1920

:�y�B�z�ڕW����
:Target Height

set scaleauto_height01=1080

:�ϊ���̃T�C�Y��ݒ肵�܂�(�P��:px)�B�A�͕��A�B�͍����ł��B
:�������w�肷��ƁA�����̊�𖞂����摜���쐬����܂��B
:�܂�A�ϊ��O�̉摜�ƇA�B�̏c���䂪������ꍇ�A
:�ϊ��O�̉摜�̉摜�̒Z���ق����A(�B)�Ɠ����ɂȂ�܂��B
:
:�A�B�̂ǂ��炩��0�ɂ���ƁA�ݒ肵�����̊�ő����܂��B
:������0�ɂ���ƁAscaleauto=false�Ɠ����ɂȂ�܂��B
:
:���͉摜���A�B�ł����������`���傫�������Ƃ��́A
:�k�����܂��B
:************************************************************
:�y�C�z�蓮�{���ݒ�[--scale_ratio]

set scale_ratio01=2

: �����{���v�Z�������̂Ƃ��Ɏg���܂��Bwaifu2x�̃f�t�H���g�ł��B
: ����(�P��:�{)�����_�B
:=============================================================
:
:�m�C�Y�������x��[--noise_level]
:

set noise_level01=2

: 1,2,super �ǂꂩ��I��
: 1�̂ق��������ʂ����Ȃ������ɒ����ł��B
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
:�g�p����waifu2x[bat�Ǝ�]
:Which do you use cpp or caffe?[This batch's own mode]
:

set usewaifu=waifu2x-converter

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
:�o�͐ݒ�[bat�Ǝ�]
:About Output
:
:************************************************************
:�y�@�z�o�̓t�H���_���[�h
:Folder output mode setting

set folderoutmode=2

:�ȉ��̐����Ŏw�肵�Ă��������B
:  0 �����̓t�H���_�Ɠ����t�H���_�ɏo�͂��܂��B
:       �A�̐ݒ�͖�������܂��B
:  1 ���A�Ŏw�肵�����O�̃t�H���_�����͂��ꂽ�t�H���_���Ƃ�
:       ��������܂��B
:  2 ���A�Ŏw�肵�����O�̃t�H���_���A��ԍŏ��ɓ��͂��ꂽ�t�@�C��
:       �̏�̊K�w�ɂ����A���̒��ɂ܂Ƃ߂ĉ摜������܂��B
:       ���Ƃ̃t�@�C���\���͈ێ�����܂��B
:  3 �� 2 �̃t�H���_���B�Őݒ肵���`���Ɉ��k���܂��B
:************************************************************
:�y�A�z�o�̓t�H���_��
:Output folder name[This batch's own mode]
:

set outfoldernameset=waifued

:�o�̓t�H���_�����w�肵�܂��B
:�g�����͇@�̐ݒ�ɂ���ĈقȂ�܂��B
:�Đ��ł���̂�.wav�݂̂ł��B
:************************************************************
:�y�B�z���k�`��
:Compression Format Setting
:

set compformat=7z

:���k�`�����w�肵�܂��B�g���q��.�͕s�v�ł��B
:�Ή��`����"7-Zip"���Ή����Ă���
:  7z, XZ, BZIP2, GZIP, TAR, ZIP, WIM
:�ł��B
:=============================================================
:
:�����I�����ɉ���炷
:BEEP
:

set endwav="C:\Windows\Media\Ring03.wav"

:�I�����ɉ���炵�܂��B�v��Ȃ��ꍇ�͋�ɂ��Ă��������B
:"�`"�ň͂����`�Ńt���p�X�Ŏw�肵�Ă��������B
:�`���ɂ��āFSox���g���Ă��܂����Awav�ł��������Ă��܂���B
:=============================================================
:
:Twitter�������[�h
:TwitterMode
:

set twittermode=false

: true(�L��)/false(����)
:
:�L���ɂ���ɂ�ImageMagick���K�v�ł��B
:true�ɂ���ƈȉ��̂��Ƃ����s���܂��B
: �@ jpeg�ɂȂ�Ȃ��悤�ɁA����������������߂��܂��B
: �A pngquant�Ńt�@�C���T�C�Y��5MB�ȉ��Ɉ��k���܂��B
:
:Twittermode����������̉摜�̓t�@�C�����̐擪��fortwitter_��
:�t���܂��B
:Twittermode�����O�̉摜���ۑ�����܂��B
:=============================================================
:
:
:���̑��I�v�V����(�㋉�җp�ݒ�)
:
:          ��ca(��)��caffe co(��)��converter-cpp
set otheropca01=
set otheropco01=
set otherop7z01=
:          ��7z(��)��7-zip
:�Ȃɂ��������Ŏw�肵�����I�v�V����������Ύw�肵�Ă��������B
:�R�}���h�v�����v�g�őł����ތ`�ŋL�����Ă��������B
:�q���g:SoX��endwav�ɏ������߂ΓK�p����܂��B
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
if "%~1" == "" exit
Title %~nx0 : waifu2x now denoising!
setlocal enabledelayedexpansion
pushd "%~dp0"
pushd ..
Path=%PATH%;%CD%
popd
popd
cd /d "%~dp0"
cd ..

set thebat="%~0"
set batdp=%~dp0
set batnx=%~nx0

set firstprocess=true
set process01=gpu
set hoge=*.%inexli01::= *.%

set multset_txt=%TMP%\mset-%~n0.txt
set fname_txt=%TMP%\fset-%~n0.txt

type NUL > "%multset_txt%"
type NUL > "%fname_txt%"

pushd "%~1" > NUL 2>&1
set pushderrorlv=%ErrorLevel%
if "%pushderrorlv%" GEQ "1" (
 goto s_file
) else (
 popd
 goto s_folder
)


:s_file

if "%folderoutmode%" == "2" (
set outfoldercd=%~dp1\%outfoldernameset%
set outfolder=%~dp1\%outfoldernameset%
) else if "%folderoutmode%" == "3" (
set outfoldercd=%TMP%\%~n0\%outfoldernameset%
set outfolder=%TMP%\%~n0\%outfoldernameset%
set lastzip=%~dp1\%outfoldernameset%.%compformat%
) else (
set outfolder=%~dp1\%outfoldernameset%
)

mkdir "!outfolder!" > NUL 2>&1
set logname=!outfolder!\w2xresult
echo %DATE% %TIME% Run %~nx0 >>"%logname%.log" 2>>&1
echo �o�̓t�H���_:"!outfolder!"
echo ���O:"%logname%.log"
goto next1

:s_folder

if "%folderoutmode%" == "2" (
set outfoldercd=%~dp1%outfoldernameset%
set outfolder=%~dp1%outfoldernameset%
) else if "%folderoutmode%" == "3" (
set outfoldercd=%TMP%\%~n0\%outfoldernameset%
set outfolder=%TMP%\%~n0\%outfoldernameset%
set lastzip=%~dp1%outfoldernameset%.%compformat%
) else (
set outfolder=%~dp1%outfoldernameset%
)

mkdir "!outfolder!" > NUL 2>&1
set logname=!outfolder!\w2xresult
echo %DATE% %TIME% Run %~nx0 >>"%logname%.log" 2>>&1
echo �o�̓t�H���_:"!outfolder!"
echo ���O:"%logname%.log"


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

:���[�h�ݒ�-�����{���ݒ�

if "%scaleauto%" == "true" (
 if "%scaleauto_width01%" == "0" (
  if "%scaleauto_height01%" == "0" (
  set scaleauto=false
  )
 )
)

if "%scaleauto%" == "true" (
identify -help > NUL 2>&1
if errorlevel 2 (
 echo ImageMagick���C���X�g�[������Ă��܂���B�����{���v�Z��TwitterMode�͖����ł��B
 echo ImageMagick���C���X�g�[������Ă��܂���B�����{���v�Z��TwitterMode�͖����ł��B >>"%logname%.log" 2>>&1
 echo ImageMagick�̃C���X�g�[�����@�̓O�O���Ă��������B
 set scaleauto=false
 set twittermode=false
)
)
:next2

:���[�h�ݒ�-�g�pwaifu
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
pushd "%~1" > NUL 2>&1
if errorlevel 1 (
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

:reduction

if "%scale_ratio01%" == "1" (
 goto noexpant
) else if "%scale_ratio01%" == "0" (
 goto noexpant
)

if %scaleauto_width01% LEQ %scaleauto_height01% (
mogrify -resize x%scaleauto_height01% "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
) else if %scaleauto_width01% GTR %scaleauto_height01% (
mogrify -resize %scaleauto_width01%x "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
)
goto end

:noexpant
if "!scale_ratio01!" == "0" (
convert "%~1" -resize x%scaleauto_height01% "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
) else if "!scale_ratio01!" == "1" (
convert "%~1" -resize %scaleauto_width01%x "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
)

goto end

:===========================================================================================================================================

:success

if "%scaleauto%" == "true" (
 echo !DATE! !TIME! �ݒ肵���傫���ɏk�����܂��B >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! �ݒ肵���傫���ɏk�����܂��B 
 call :reduction "%~1"
)

echo !DATE! !TIME! "%~nx1"�̕ϊ���Ƃ�����ɏI�����܂����B >>"%logname%.log" 2>>&1
echo �����摜��:!mode01nam! >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~nx1"�̕ϊ���Ƃ�����ɏI�����܂����B
echo �����摜��:!mode01nam!

if "%twittermode%" == "true" (
 echo !DATE! !TIME! �Â��āAtwitter���e�p�摜���쐬���܂��B >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! �Â��āAtwitter���e�p�摜���쐬���܂��B
 call %batdp%\twittermode.bat "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! twitter���e�p�摜�̍쐬���������܂����B >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! twitter���e�p�摜�̍쐬���������܂����B
 echo �����摜��:forTwitter_!mode01nam!
)

goto end

:===========================================================================================================================================

:namer

if !scale_ratio01! LEQ 1 goto nam_noiseorno
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
:nam_noiseorno
if "%mode01%" == "auto_scale" (
if /I "%~x1" == ".jpg" (
 goto nam_b
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_b
 ) else (
 set nowaifu=true
 set mode01nam=%~n1_reduced!exte!
 echo !DATE! !TIME! �k�������s���܂��B >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! �k�������s���܂��B
 call :success "%~1"
 call wtb.bat STOP
 echo . >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo .
 call wtb.bat PRINT
 exit /b
 )
) else (
 set nowaifu=true
 set mode01nam=%~n1_reduced!exte!
 echo !DATE! !TIME! �k�������s���܂��B >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! �k�������s���܂��B
 call :success "%~1"
 call wtb.bat STOP
 echo . >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo .
 call wtb.bat PRINT
 exit /b
)
:nam_a
set mode01nam=%~n1_waifu2x-noise_scale-%model01%-Lv%noise_level01%-!scale_ratio01!x!exte!
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONam

:nam_b

set mode01nam=%~n1_waifu2x-noise-%model01%-Lv%noise_level01%!exte!
set mode01var=-m noise --noise_level %noise_level01%
goto EONam

:nam_c

set mode01nam=%~n1_waifu2x-scale-%model01%-!scale_ratio01!x!exte!
set mode01var=-m scale --scale_ratio %scale_ratio01%
goto EONam

:EONam
goto end

:===========================================================================================================================================

:multiplier

echo !DATE! !TIME! �{���������v�Z���܂��B >>"%logname%.log" 2>>&1
echo !DATE! !TIME! �{���������v�Z���܂��B
CScript "%batdp%\script\multiplier.js" "%~1" %scaleauto_width01% %scaleauto_height01% "%multset_txt%" %accuracy% > NUL 2>&1
set /P scale_ratio01= < "%multset_txt%"
type NUL > "%multset_txt%
if !scale_ratio01! LEQ 1 (
echo !DATE! !TIME! �v�Z���� : �g�債�܂���B
) else (
echo !DATE! !TIME! �v�Z���� : %scale_ratio01%�{�Ɋg�債�A��������k�����܂��B
)

goto end

:===========================================================================================================================================

:dow2x



if "%folderoutmode%" == "0" (
set outfolder=%~dp1%
) else if "%folderoutmode%" == "1" (
set outfolder=%~dp1%\%outfoldernameset%
)

mkdir "!outfolder!" > NUL 2>&1

if "%out_ext01%" NEQ "" (
 set exte=.%out_ext01%
 ) else (
 set exte=%~x1
 )

if "%scaleauto%" == "true" call :multiplier "%~1"

call :namer "%~1"
if "!nowaifu!" == "true" exit /b

echo.
echo. >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�... >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"�̕ϊ����J�n���܂�...


if "!usewaifu:converter=!" NEQ "!usewaifu!" (
!usewaifu! --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "!outfolder!\!mode01nam!" %otheropco01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
!usewaifu! -p !process01! --model_dir ".\models\%model01%" !mode01var! -i "%~1" -o "!outfolder!\!mode01nam!" -l %inexli01% -e %ex:~1% %otheropca01% >>"%logname%.log" 2>>&1
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
 call :success "%~1"
 )
 call wtb.bat STOP
 echo . >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo .
 call wtb.bat PRINT

goto end

:===========================================================================================================================================

:outfilename_a

CScript "%batdp%\script\outfilename.js" "%outfoldercd%" "%outfoldernameset%" "%~dp1" "%fname_txt%" "false" > NUL 2>&1
set /P outfolder= < "%fname_txt%"
type NUL > "%fname_txt%

goto end

:outfilename_b

CScript "%batdp%\script\outfilename.js" "%outfoldercd%" "%outfoldernameset%" "%~dp1" %fname_txt% "%~2" > NUL 2>&1
set /P outfolder= < "%fname_txt%"
type NUL > "%fname_txt%

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

if "%folderoutmode%" == "2" (
call :outfilename_a "%~1"
) else if "%folderoutmode%" == "3" (
call :outfilename_a "%~1"
)

call :dow2x "%~1"

:nextforex
 shift
 if "%~1" == "" goto Finish_w2x
 goto shiwake
 
:===========================================================================================================================================
:w2x_folder

pushd "%~1"
echo %DATE% %TIME% "%~1"�̏������J�n���܂�...[�t�H���_���[�h]
if "%subf01%" == "true" (
 rem �T�u�t�H���_�������[�h
 for /R %%t in (%hoge%) do call :w2xf1 "%%~t" true "%~1"
 ) else (
 for %%t in (%hoge%) do call :w2xf1 "%~1\%%~t"
 )
shift
if "%~1" == "" goto Finish_w2x
goto shiwake
 
:w2xf1
popd
call wtb.bat START
set cafname=%~n1
if not "!cafname:waifu2x=hoge!" == "!cafname!" exit /b >>"%logname%.log" 2>>&1

if "%folderoutmode%" == "2" (
if "%2" == "true" (
call :outfilename_b "%~1" "%~3"
) else (
call :outfilename_a "%~1"
)
) else if "%folderoutmode%" == "3" (
if "%2" == "true" (
call :outfilename_b "%~1" "%~3"
) else (
call :outfilename_a "%~1"
)
)

call :dow2x "%~1"

goto end
:===========================================================================================================================================

:Finish_w2x
echo ------------------------------------------- >>"%logname%.log" 2>>&1
echo -------------------------------------------
echo Finish: %batnx% >>"%logname%.log" 2>>&1
echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B >>"%logname%.log" 2>>&1
echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B

call wta.bat STOP
call wta.bat PRINT >>"%logname%.log" 2>>&1
call wta.bat PRINT


if "%folderoutmode%" == "3" (
echo !DATE! !TIME! 7-ZIP�ň��k���J�n���܂��B
echo !DATE! !TIME! 7-ZIP�ň��k�����܂����B >>"%logname%.log" 2>>&1
echo ------------------------------------------- >>"%logname%.log" 2>>&1
echo ------------------------------------------- >>"%logname%.log" 2>>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
7za64 a "%lastzip%" "%outfoldercd%" %otherop7z01%
) else (
7za a "%lastzip%" "%outfoldercd%"%otherop7z01%
)

echo !DATE! !TIME! 7-ZIP�ň��k���������܂����B
echo "%lastzip%"
rd /S /Q "%outfoldercd%" > NUL 2>&1
) else (
echo ------------------------------------------- >>"%logname%.log" 2>>&1
echo ------------------------------------------- >>"%logname%.log" 2>>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
echo. >>"%logname%.log" 2>&1
)

Del "%multset_txt%"
Del "%fname_txt%"

set AUDIODRIVER=waveaudio
if not "%endwav%" == "" (
play %endwav%
)

pause
exit
:end