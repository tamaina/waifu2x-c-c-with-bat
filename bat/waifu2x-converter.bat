@echo off
:=============================================================
:#############################################################
:設定
:#############################################################
: 設定方法
:set xx01=[モード]←深いことは考えず=の後ろを書き換えてください
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
:サブフォルダも処理する[bat独自]
:

set subf01=true

: true/false(有効/無効)
:=============================================================
:
:出力フォルダ名[bat独自]
:

set outfolder=waifued


:そんな深いことは考えずwaifuedと名付けましたがやっぱ変かも
:しれないので変更できるようにしてみたり
:=============================================================
:分割の計算にも対応したいなぁとか思ったり
:#############################################################
:諸注意
:#############################################################
:・出力画像名は
: [元画像名]_waifu2xco-[処理モード]-Lv[ノイズLv]-[拡大率]x.jpg
:  となります。
:
:（例）
:　　waifu2xco-noise_scale-Lv1-4x_asoboy.jpg
:
:
:この下から処理用のプログラムが始まります。
:=============================================================














































:準備
setlocal enabledelayedexpansion
set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga
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
echo %DATE% %TIME% ファイルモード
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [ファイルモード] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dp1\%outfolder%"を作成
echo %DATE% %TIME% "%logname%.log"を作成(すでにある場合は追記します。)
cd /d %~dp0 >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
goto next1

:s_folder
set datcdd=%~d0
set datcdp=%~p0
set datcdn=%~n0

mkdir %~dpn1\%outfolder%
set logname=%~dpn1\%outfolder%\result
echo %DATE% %TIME% フォルダモード
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [フォルダモード] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dpn1\%outfolder%"を作成
echo %DATE% %TIME% "%logname%.log"を作成(すでにある場合は追記します。)
cd /d %~dp0 >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1


:next1
call wta.bat START

:CPU検出
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
 set usewaifu=waifu2x-converter_x64
 echo %DATE% %TIME% 64bitCPUを検出しました。64bit版waifu2x-converterで処理します。
 echo %DATE% %TIME% 64bitCPUを検出しました。64bit版waifu2x-converterで処理します。 >>%logname%.log 2>>&1
 ) else (
 set usewaifu=waifu2x-converter
 echo %DATE% %TIME% 32bitCPUを検出しました。32bit版waifu2x-converterで処理します。
 echo %DATE% %TIME% 32bitCPUを検出しました。32bit版waifu2x-converterで処理します。 >>%logname%.log 2>>&1
 )



:渡す変数(モード関係)

:set mode01var=-m %mode01% --noise_level %noise_level01% --scale_ratio %scale_ratio01% -l
echo %DATE% %TIME% 初期準備が完了しました。 >>%logname%.log 2>>&1
echo %DATE% %TIME% 初期準備が完了しました。
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------


if "%folder%" == "true" (
 echo %DATE% %TIME% フォルダモード >>%logname%.log 2>>&1
 echo %DATE% %TIME% フォルダモード
 goto w2xco_folder
 ) else (
 echo %DATE% %TIME% ファイルモード >>%logname%.log 2>>&1
 echo %DATE% %TIME% ファイルモード
 goto w2xco_file
 )

:===========================================================================================================================================

:w2xco_file
call wtb.bat START
:ファイル名

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
set mode01nam=%~n1_waifu2x-%mode01%-Lv%noise_level01%-%scale_ratio01%x%~x1
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONam

:nam_b

set mode01nam=%~n1_waifu2x-noise-Lv%noise_level01%%~x1
set mode01var=-m noise --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONam

:nam_c

set mode01nam=%~n1_waifu2x-%mode01%-%scale_ratio01%x%~x1
set mode01var=-m scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONam

:EONam

if "%~1" == "" goto Finish_w2xco


echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換を開始します... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換を開始します...

%usewaifu% --model_dir ".\models\%model01%" %mode01var% -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\%mode01nam%" >>%logname%.log 2>>&1


set w2xcERROR=%ERRORLEVEL%

if "%w2xcERROR%" GEQ "1" (
 echo エラー >>%logname%.log 2>>&1
 echo エラー
 ) else (
 echo %DATE% %TIME% "%~1"の変換作業が正常に終了しました。生成画像名:%mode01nam% >>%logname%.log 2>>&1
 echo %DATE% %TIME% "%~1"の変換作業が正常に終了しました。生成画像名:%mode01nam%
 )
  call wtb.bat STOP
 echo "%~1"変換時間 >>%logname%.log 2>>&1
 call wtb.bat PRINT >>%logname%.log 2>>&1
 echo "%~1"変換時間
 call wtb.bat PRINT
 shift
 goto EONam

:===========================================================================================================================================
:w2xco_folder
pushd %~dpn1
set hoge=*.%inexli01::= *.%
echo %hoge% 
if "%subf01%" == "true" (
 echo サブフォルダ処理モード >>%logname%.log 2>>&1
 for /R %%t in (%hoge%) do call :w2xcof1 "%%~t"
 ) else (
 for %%t in (%hoge%) do call :w2xcof1 "%~dpn1\%%~t"
 )

goto  Finish_w2xco



:w2xcof1
popd
set cafname=%~n1
if not "!cafname:waifu2x=hoge!" == "!cafname!" exit /b >>%logname%.log 2>>&1

mkdir %~dp1\%outfolder%

call wtb.bat START

:ファイル名

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
echo !DATE! !TIME! "%~1"の変換を開始します... >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します...

%usewaifu% --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\!mode01nam!" >>%logname%.log 2>>&1


set w2xcERROR=!ERRORLEVEL!

if "!w2xcERROR!" GEQ "1" (
 echo エラー >>%logname%.log 2>>&1
 echo エラー
 ) else (
 echo !DATE! !TIME! "%~1"の変換作業が正常に終了しました。生成画像名:!mode01nam! >>%logname%.log 2>>&1
 echo !DATE! !TIME! "%~1"の変換作業が正常に終了しました。生成画像名:!mode01nam!
 )
 call wtb.bat STOP
 echo "%~1"変換時間 >>%logname%.log 2>>&1
 call wtb.bat PRINT >>%logname%.log 2>>&1
 echo "%~1"変換時間
 call wtb.bat PRINT


exit /b
 
:===========================================================================================================================================

:Finish_w2xco



echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------
echo %DATE% %TIME% Finish waifu2x-converter.bat >>%logname%.log 2>>&1
echo これで読み込まれた全ての画像の変換が完了しました。 >>%logname%.log 2>>&1

echo これで読み込まれた全ての画像の変換が完了しました。
call wta.bat STOP
echo waifu2x-converter.bat実行時間 >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1

echo waifu2x-converter.bat実行時間
call wta.bat PRINT

echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1
echo ------------------------------------------- >>%logname%.log 2>>&1
echo. >>%logname%.log 2>&1
echo. >>%logname%.log 2>&1

pause
:end