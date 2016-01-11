@echo off
:=============================================================
:#############################################################
:設定
:#############################################################
: 設定方法
:set xx01=[モード]←書き換えてください
:=============================================================
:
:動作モード[-m --mode]
:

set mode01=auto_scale

: auto_scale(拡大・jpegならノイズ除去もする)
: noise_scale(ノイズ除去・拡大)
: noise(ノイズ除去)
: scale(拡大)
:=============================================================
:
:モデル選択[--model_dir]
:

set model01=anime_style_art_rgb

: anime_style_art(二次画像 輝度のみ)
: anime_style_art_rgb(二次画像 RGBで)
: photo(写真)
:=============================================================
:
:拡大率[--scale_ratio]
:

set scale_ratio01=2

: 数字(単位 倍)小数点可
:=============================================================
:
:ノイズ除去レベル[--noise_level]
:

set noise_level01=1

: 1,2 どちらかを選択
: 1のほうが除去量が少なく現物に忠実
:=============================================================
:
:フォルダ内の変換する拡張子[-l --input_extention_list]
:

set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga

: 区切り文字は " : "(コロン) 最後にはつけない
: 大文字小文字区別なし
:=============================================================
:
:出力拡張子[-e --output_extention]
:

set out_ext01=png

: デフォルトはpng
: 指定できるのは一つです(このbatの仕様です)
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
:諸注意
:#############################################################
:・出力画像名は
: waifu2xc-[処理モード]-Lv[ノイズLv]-[拡大率]x_[元画像名].jpg
:  となります。
:（例）
:　　waifu2x-noise_scale-Lv1-4x_asoboy.jpg
:
:
:この下から処理用のプログラムが始まります。
:=============================================================














































:準備
set datcdd=%~d0
set datcdp=%~p0
set datcdn=%~n0
set process01=gpu
mkdir "%~dp1\waifued"
echo %DATE% %TIME% "%~dp1\waifued"を作成
set logname=%~dp1\waifued\result
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) >>%logname%.log 2>>&1
echo %DATE% %TIME% %logname%.logを作成(すでにある場合は追記します。)
cd /d %~dp0 >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
call wta.bat BEGIN

:CPU検出

if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
 echo %DATE% %TIME% 64bitCPUを確認しました。
 echo %DATE% %TIME% 64bitCPUを確認しました。>>%logname%.log 2>>&1
 ) else (
 set usewaifu=waifu2x-converter
 echo %DATE% %TIME% お使いのCPUは32bitです。waifu2x-caffeは32bitCPUでは使えません。waifu2x-converterをお使いください。
 echo %DATE% %TIME% お使いのCPUは32bitです。waifu2x-caffeは32bitCPUでは使えません。waifu2x-converterをお使いください。 >>%logname%.log 2>>&1
 echo 終了するには何かキーを押してください。
 pause > NUL
 exit
 )


:loop
if "%~1" == "" goto end
echo %DATE% %TIME% 初期準備が完了しました。
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------
call wtb.bat BEGIN

echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換を開始します... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換を開始します...

:渡す変数(モード関係)

set mode01var=-p %process01% -m %mode01% --noise_level %noise_level01% --scale_ratio %scale_ratio01% -l %inexli01% -e %out_ext01%

:ファイル名

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
 echo %DATE% %TIME% gpuでの変換を試みましたが、できませんでした。cpuでの変換を開始します。 >>%logname%.log 2>>&1
 echo %DATE% %TIME% gpuでの変換を試みましたが、できませんでした。cpuでの変換を開始します。
 goto Beg_w2xc
 )

echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換作業が終了しました。 >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換作業が終了しました。
echo. >>%logname%.log 2>&1
echo.
echo "%~1"変換時間 >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1
echo "%~1"変換時間
call wtb.bat PRINT
call wtb.bat STOP

shift
goto loop

:end
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------
echo %DATE% %TIME% Finish waifu2x-caffe.bat >>%logname%.log 2>>&1
echo これで読み込まれた全ての画像の変換が完了しました。 >>%logname%.log 2>>&1

echo これで読み込まれた全ての画像の変換が完了しました。

echo waifu2x-converter.bat実行時間 >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1

echo waifu2x-converter.bat実行時間
call wta.bat PRINT
call wta.bat STOP
echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1
echo ------------------------------------------- >>%logname%.log 2>>&1
echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1
:EOF
pause