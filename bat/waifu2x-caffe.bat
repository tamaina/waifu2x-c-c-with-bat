@echo off
:=============================================================
:#############################################################
:設定
:#############################################################
: 設定方法
:set xx01=[モード]←深いことは考えず=の後ろを書き換えてください
:Don't think. Please feel.
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

set model01=photo

: anime_style_art (二次画像 輝度のみ)
: anime_style_art_rgb (二次画像 RGBで)
: photo (写真)
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

set noise_level01=2

: 1,2,super どちらかを選択
: 1のほうが除去量が少なく現物に忠実
: superは0.9のめちゃくちゃ強力なモデルです。
: superはphoto版が用意されていません。
:=============================================================
:
:変換する拡張子[-l --input_extention_list]
:

set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga

: 区切り文字は " : "(コロン)。最後にはつけない
: 大文字小文字区別なし
:=============================================================
:
:出力拡張子[-e --output_extention]
:

set out_ext01=png

: 指定しない場合は空(=の次は改行)にする。 スペースを入れるな
: デフォルトはpng。" . "(ドット)をつけない
: 指定できるのは一つです(このbatの仕様です)
:=============================================================
:
:フォルダを処理するときサブフォルダも処理する[bat独自]
:Recursion[This batch's own mode]
:

set subf01=true

: true/false(有効/無効)
:=============================================================
:
:出力フォルダ名[bat独自]
:Output folder name[This batch's own mode]
:

set outfolder=waifued

:そんな深いことは考えずwaifuedと名付けましたがやっぱ変かも
:しれないので変更できるようにしてみたり
:
:空白にすれば同じフォルダに出力できるんじゃないかと思う
:=============================================================
:
:使用するwaifu2x[bat独自]
:Which do you use cpp or caffe?[This batch's own mode]
:

set usewaifu=waifu2x-caffe-cui

:使用するwaifu2xを選択します。
:
: waifu2x-converter_x64 (cpp64bit)
: waifu2x-converter     (cpp32bit/64bit自動選択)
: waifu2x-caffe-cui     (caffe)
:
:上記以外を入力するとエラーを吐きます。
:何も書かないと、自動的に判断します。
:=============================================================
:
:その他オプション(上級者用設定)
:
:          ↓ca(上)がcaffe co(下)がconverter-cpp
set otheropca01=
set otheropco01=

:なにかご自分で指定したいオプションがあれば指定してください。
:コマンドプロンプトで打ち込む形で記入してください。
:=============================================================
:分割の計算にも対応したいなぁとか思ったり
:#############################################################
:諸注意
:#############################################################
:・出力画像名は
: [元画像名]_waifu2xco-[処理モード]-[モデル]-Lv[ノイズLv]-[拡大率]x.jpg
:  となります。
:
:（例）
:　　waifu2xco-noise_scale-photo-Lv1-4x_motogazounonamae.jpg
:
:
:この下から処理用のプログラムが始まります。
:=============================================================















































:===========================================================================================================================================
:準備
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
echo %DATE% %TIME% "%~dp1\%outfolder%"を作成(すでにある場合その旨が書かれています)
echo %DATE% %TIME% "%logname%.log"を作成(すでにある場合は追記します。)
cd /d %~dp0 >>"%logname%.log" 2>>&1
cd .. >>"%logname%.log" 2>>&1
goto next1

:s_folder

mkdir "%~dpn1\%outfolder%"
set logname=%~dpn1\%outfolder%\w2xresult
echo %DATE% %TIME% Run %~nx0 >>"%logname%.log" 2>>&1
echo %DATE% %TIME% "%~dpn1\%outfolder%"を作成(すでにある場合その旨が書かれています)
echo %DATE% %TIME% "%logname%.log"を作成(すでにある場合は追記します。)
cd /d "%~dp0" >>"%logname%.log" 2>>&1
cd .. >>"%logname%.log" 2>>&1


:next1
call wta.bat START

:super処理
if "%noise_level01%" == "super" (
 if "%model01%" == "photo" (
 echo photoモデルではsuperが使えません。anime_style_art_rgbモデルで処理します。
 echo photoモデルではsuperが使えません。anime_style_art_rgbモデルで処理します。 >>"%logname%.log" 2>>&1
 set model01=super-anime_style_art_rgb
 set noise_level01=2
 ) else if not "%model01:anime_style_art=hoge%" == "%model01%" (
 set model01=super-%model01%
 set noise_level01=2
 )
)


:モード設定
if "%usewaifu%" == "" (
  if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
  
 set usewaifu=waifu2x-caffe-cui
 set autochoosecc=step1
 echo %DATE% %TIME% 64bitCPUを検出しました。はじめにwaifu2x-caffeで処理します。
 echo %DATE% %TIME% 64bitCPUを検出しました。はじめにwaifu2x-caffeで処理します。 >>"%logname%.log" 2>>&1
 goto shiwake
  ) else (
 set usewaifu=waifu2x-converter
 echo %DATE% %TIME% 32bitCPUを検出しました。32bit版waifu2x-converterで処理します。
 echo %DATE% %TIME% 32bitCPUを検出しました。32bit版waifu2x-converterで処理します。 >>"%logname%.log" 2>>&1
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
 echo Error！！！ >>"%logname%.log" 2>>&1
 echo Error！！！
 echo いずれかのファイルの名前に処理できない文字が含まれているようです。^;や^,がないか確認してください。 >>"%logname%.log" 2>>&1
 echo いずれかのファイルの名前に処理できない文字が含まれているようです。^;や^,がないか確認してください。
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
 echo Error！！！ >>"%logname%.log" 2>>&1
 echo Error！！！
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
echo !DATE! !TIME! "%~1"の変換を開始します... >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します...


if "!usewaifu:converter=!" NEQ "!usewaifu!" (
!usewaifu! --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\%outfolder%\!mode01nam!" %otheropco01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
!usewaifu! -p !process01! --model_dir ".\models\%model01%" !mode01var! -i "%~1" -o "%~dp1\%outfolder%\!mode01nam!" -l %inexli01% -e %ex:~1% %otheropca01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else (
echo Error！！！ 0x00 >>"%logname%.log" 2>>&1
echo Error！！！ 0x00
exit /b
)

if "!w2xERROR!" GEQ "1" (
 if "!autochoosecc!" == "step1" (
  set usewaifu=waifu2x-converter_x64
  set autochoosecc=step2
  echo !DATE! !TIME! caffeでGPUでの変換を試みましたが、できませんでした。converterに移しその他のハードでの変換を開始します。 >>"%logname%.log" 2>>&1
  echo !DATE! !TIME! caffeでGPUでの変換を試みましたが、できませんでした。converterに移しその他のハードでの変換を開始します。
  goto dow2x
 ) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
  if "!process01!" == "gpu" (
  set process01=cpu
  echo !DATE! !TIME! caffeでGPUでの変換を試みましたが、できませんでした。cpuで変換します。 >>"%logname%.log" 2>>&1
  echo !DATE! !TIME! caffeでGPUでの変換を試みましたが、できませんでした。cpuで変換します。
  goto dow2x
  ) else (
  echo Error！！！ 0x01 >>"%logname%.log" 2>>&1
  echo Error！！！ 0x01
  exit /b
  )
 ) else (
  echo Error！！！ 0x02 >>"%logname%.log" 2>>&1
  echo Error！！！ 0x02
  exit /b
 )
 ) else (
 echo !DATE! !TIME! "%~nx1"の変換作業が正常に終了しました。 >>"%logname%.log" 2>>&1
 echo 生成画像名:!mode01nam! >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! "%~nx1"の変換作業が正常に終了しました。
 echo 生成画像名:!mode01nam!
 )
 call wtb.bat STOP
 echo "%~1"変換時間 >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo "%~1"変換時間
 call wtb.bat PRINT

goto end

:===========================================================================================================================================

:w2x_file
call wtb.bat START

:inexli01にあってるか確認する
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

 echo "%~nx1"を読み込みましたが、バッチファイルで指定された拡張子の中に"%~x1"がなかったため変換しません。 >>"%logname%.log" 2>>&1
 echo "%~nx1"を読み込みましたが、バッチファイルで指定された拡張子の中に"%~x1"がなかったため変換しません。
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

echo %DATE% %TIME% "%~1"の処理を開始します...[フォルダモード]
if "%subf01%" == "true" (
 echo サブフォルダ処理モード >>"%logname%.log" 2>>&1
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
echo これで読み込まれた全ての画像の変換が完了しました。 >>"%logname%.log" 2>>&1

echo これで読み込まれた全ての画像の変換が完了しました。
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