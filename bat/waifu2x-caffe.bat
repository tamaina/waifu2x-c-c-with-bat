@echo off
:=============================================================
:#############################################################
:�ݒ�
:#############################################################
: �ݒ���@
:set xx01=[���[�h]�����������Ă�������
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



:
:
:=============================================================
:=============================================================
:=============================================================
:=============================================================
:=============================================================
:=============================================================
:#############################################################
:������
:#############################################################
:�E�o�͉摜����
: waifu2xc-[�������[�h]-Lv[�m�C�YLv]-[�g�嗦]x_[���摜��].jpg
:  �ƂȂ�܂��B
:�i��j
:�@�@waifu2x-noise_scale-Lv1-4x_asoboy.jpg
:
:
:���̉����珈���p�̃v���O�������n�܂�܂��B
:=============================================================














































:����
set datcdd=%~d0
set datcdp=%~p0
set datcdn=%~n0
set process01=gpu
mkdir "%~dp1\waifued"
echo %DATE% %TIME% "%~dp1\waifued"���쐬
set logname=%~dp1\waifued\result
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) >>%logname%.log 2>>&1
echo %DATE% %TIME% %logname%.log���쐬(���łɂ���ꍇ�͒ǋL���܂��B)
cd /d %~dp0 >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
call wta.bat BEGIN

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


:loop
if "%~1" == "" goto end
echo %DATE% %TIME% �����������������܂����B
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------
call wtb.bat BEGIN

echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ����J�n���܂�...

:�n���ϐ�(���[�h�֌W)

set mode01var=-p %process01% -m %mode01% --noise_level %noise_level01% --scale_ratio %scale_ratio01% -l %inexli01% -e %out_ext01%

:�t�@�C����

if "%mode01%" == "auto_scale" goto nam_auto
if "%mode01%" == "noise_scale" goto nam_a
if "%mode01%" == "noise" goto nam_b
if "%mode01%" == "scale" goto nam_c

:nam_auto
if "%~x1" == ".jpg" (
 goto nam_a
 ) else if "%~x1" == ".jpeg" (
 goto nam_a
 ) else (
 goto nam_c
 ) 
 
:nam_a
set mode01nam=waifu2x-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
goto EONam

:nam_b

set mode01nam=waifu2x-%mode01%-%scale_ratio01%x.%out_ext01%
goto EONam

:nam_c

set mode01nam=waifu2x-%mode01%-%scale_ratio01%x.%out_ext01%
goto EONam

:EONam
:Beg_w2xc

waifu2x-caffe-cui --model_dir ".\models\%model01%" %mode01var% -i "%~1" -o "%~dp1\waifued\%mode01nam%" >>%logname%.log 2>>&1

set w2xcERROR=%ERRORLEVEL%

if "%w2xcERROR%" GEQ "1" (
 set process01=cpu
 echo %DATE% %TIME% gpu�ł̕ϊ������݂܂������A�ł��܂���ł����Bcpu�ł̕ϊ����J�n���܂��B >>%logname%.log 2>>&1
 echo %DATE% %TIME% gpu�ł̕ϊ������݂܂������A�ł��܂���ł����Bcpu�ł̕ϊ����J�n���܂��B
 goto Beg_w2xc
 )

echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ���Ƃ��I�����܂����B >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"�̕ϊ���Ƃ��I�����܂����B
echo. >>%logname%.log 2>&1
echo.
echo "%~1"�ϊ����� >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1
echo "%~1"�ϊ�����
call wtb.bat PRINT
call wtb.bat STOP

shift
goto loop

:end
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------
echo %DATE% %TIME% Finish waifu2x-caffe.bat >>%logname%.log 2>>&1
echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B >>%logname%.log 2>>&1

echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B

echo waifu2x-converter.bat���s���� >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1

echo waifu2x-converter.bat���s����
call wta.bat PRINT
call wta.bat STOP
echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1
echo ------------------------------------------- >>%logname%.log 2>>&1
echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1
:EOF
pause