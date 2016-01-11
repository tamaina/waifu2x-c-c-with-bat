@echo off
:=============================================================
:#############################################################
:設定
:#############################################################
: 設定方法
:set xx01=[モード]←書き換えてください
:=============================================================
:動作モード[-m --mode]

set mode01=noise_scale

: noise_scale(ノイズ除去・拡大)
: noise(ノイズ除去)
: scale(拡大)
:=============================================================
:モデル選択[--model_dir]

set model01=anime_style_art_rgb

: anime_style_art(二次画像 輝度のみ)
: anime_style_art_rgb(二次画像 RGBで)
: photo(写真)
:=============================================================
:拡大率[--scale_ratio]

set scale_ratio01=2

: 数字(単位 倍)小数点可
:=============================================================
:ノイズ除去レベル[noise_level]

set noise_level01=1

: 1,2 どちらかを選択
: 1のほうが除去量が少なく現物に忠実
:=============================================================
:#############################################################
:諸注意
:#############################################################
:・64bitと32bitの判別を自動で行います。
:・CPUコア数=プロセス数としています。
:・出力画像名は
: waifu2x-[処理モード]-Lv[ノイズLv]-[拡大率]x_[元画像名].jpg
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
 set usewaifu=waifu2x-converter_x64
 echo %DATE% %TIME% 64bitCPUを検出しました。64bit版waifu2x-converterで処理します。
 echo %DATE% %TIME% 64bitCPUを検出しました。64bit版waifu2x-converterで処理します。 >>%logname%.log 2>>&1
 ) else (
 set usewaifu=waifu2x-converter
 echo %DATE% %TIME% 32bitCPUを検出しました。32bit版waifu2x-converterで処理します。
 echo %DATE% %TIME% 32bitCPUを検出しました。32bit版waifu2x-converterで処理します。 >>%logname%.log 2>>&1
 )

:渡す変数とファイル名

set mode01var=-m %mode01% --noise_level %noise_level01% --scale_ratio %scale_ratio01%
set mode01nam=%mode01%-Lv%noise_level01%-%scale_ratio01%x

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

%usewaifu% --model_dir ".\models\%model01%" %mode01var% -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\waifu2x-%mode01nam%_%~nx1" >>%logname%.log 2>>&1

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
echo %DATE% %TIME% Finish waifu2x-converter.bat >>%logname%.log 2>>&1
echo これで読み込まれた全ての画像の変換が完了しました。 >>%logname%.log 2>>&1

echo これで読み込まれた全ての画像の変換が完了しました。

echo waifu2x-converter.bat実行時間 >>%logname%.log 2>>&1
call wta.bat PRINT >>%logname%.log 2>>&1

echo waifu2x-converter.bat実行時間
call wta.bat PRINT
call wta.bat STOP

pause