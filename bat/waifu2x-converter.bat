@echo off
:=============================================================
:#############################################################
:�ݒ�
:#############################################################
: �ݒ���@
:set xx01=[���[�h]�����������Ă�������
:=============================================================
:���샂�[�h[-m --mode]

set mode01=noise_scale

: noise_scale(�m�C�Y�����E�g��)
: noise(�m�C�Y����)
: scale(�g��)
:=============================================================
:���f���I��[--model_dir]

set model01=anime_style_art_rgb

: anime_style_art(�񎟉摜 �P�x�̂�)
: anime_style_art_rgb(�񎟉摜 RGB��)
: photo(�ʐ^)
:=============================================================
:�g�嗦[--scale_ratio]

set scale_ratio01=2

: ����(�P�� �{)�����_��
:=============================================================
:�m�C�Y�������x��[noise_level]

set noise_level01=1

: 1,2 �ǂ��炩��I��
: 1�̂ق��������ʂ����Ȃ������ɒ���
:=============================================================
:#############################################################
:������
:#############################################################
:�E64bit��32bit�̔��ʂ������ōs���܂��B
:�ECPU�R�A��=�v���Z�X���Ƃ��Ă��܂��B
:�E�o�͉摜����
: waifu2x-[�������[�h]-Lv[�m�C�YLv]-[�g�嗦]x_[���摜��].jpg
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
 set usewaifu=waifu2x-converter_x64
 echo %DATE% %TIME% 64bitCPU�����o���܂����B64bit��waifu2x-converter�ŏ������܂��B
 echo %DATE% %TIME% 64bitCPU�����o���܂����B64bit��waifu2x-converter�ŏ������܂��B >>%logname%.log 2>>&1
 ) else (
 set usewaifu=waifu2x-converter
 echo %DATE% %TIME% 32bitCPU�����o���܂����B32bit��waifu2x-converter�ŏ������܂��B
 echo %DATE% %TIME% 32bitCPU�����o���܂����B32bit��waifu2x-converter�ŏ������܂��B >>%logname%.log 2>>&1
 )

:�n���ϐ��ƃt�@�C����

set mode01var=-m %mode01% --noise_level %noise_level01% --scale_ratio %scale_ratio01%
set mode01nam=%mode01%-Lv%noise_level01%-%scale_ratio01%x

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

%usewaifu% --model_dir ".\models\%model01%" %mode01var% -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\waifu2x-%mode01nam%_%~nx1" >>%logname%.log 2>>&1

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
echo %DATE% %TIME% Finish waifu2x-converter.bat >>%logname%.log 2>>&1
echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B >>%logname%.log 2>>&1

echo ����œǂݍ��܂ꂽ�S�Ẳ摜�̕ϊ����������܂����B

echo waifu2x-converter.bat���s���� >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1

echo waifu2x-converter.bat���s����
call wta.bat PRINT
call wta.bat STOP

pause