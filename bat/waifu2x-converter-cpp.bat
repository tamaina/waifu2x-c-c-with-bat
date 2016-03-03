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
:拡大率(+自動設定)[--scale_ratio]+[bat独自]
:About "scale_ratio"
:
:************************************************************
:【①】自動倍率計算モードon/off
:Auto Calculate Magnification

set scaleauto=false

:拡大率を自動で計算してすべての画像の幅または高さをそろえます。
:true(有効)/false(無効)
:
:有効にする場合、ImageMagicが必要です。
:
:trueにした場合、必ず②③の設定をしてください。
:falseにした場合、④の設定が適用されます。
:
:************************************************************
:【②】目標幅
:Target Width

set scaleauto_width01=1920

:【③】目標高さ
:Target Height

set scaleauto_height01=1080

:変換後のサイズを設定します(単位:px)。②は幅、③は高さです。
:両方を指定すると、両方の基準を満たす画像が作成されます。
:つまり、変換前の画像と②③の縦横比が違った場合、
:変換前の画像の画像の短いほうが②(③)と同じになります。
:
:②③のどちらかを0にすると、設定した方の基準で揃えます。
:両方を0にすると、scaleauto=falseと同じになります。
:
:入力画像が②③でつくった長方形より大きかったときは、
:縮小します。
:************************************************************
:【④】手動倍率設定[--scale_ratio]

set scale_ratio01=2

: 自動倍率計算が無効のときに使います。waifu2xのデフォルトです。
: 数字(単位:倍)小数点可。
:=============================================================
:
:ノイズ除去レベル[--noise_level]
:

set noise_level01=2

: 1,2,super どれかを選択
: 1のほうが除去量が少なく現物に忠実です。
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
:使用するwaifu2x[bat独自]
:Which do you use cpp or caffe?[This batch's own mode]
:

set usewaifu=waifu2x-converter

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
:出力設定[bat独自]
:About Output
:
:************************************************************
:【①】出力フォルダモード
:Folder output mode setting

set folderoutmode=2

:以下の数字で指定してください。
:  0 →入力フォルダと同じフォルダに出力します。
:       ②の設定は無視されます。
:  1 →②で指定した名前のフォルダが入力されたフォルダごとに
:       生成されます。
:  2 →②で指定した名前のフォルダが、一番最初に入力されたファイル
:       の上の階層につくられ、その中にまとめて画像が入ります。
:       もとのファイル構造は維持されます。
:  3 → 2 のフォルダを③で設定した形式に圧縮します。
:************************************************************
:【②】出力フォルダ名
:Output folder name[This batch's own mode]
:

set outfoldernameset=waifued

:出力フォルダ名を指定します。
:使われ方は①の設定によって異なります。
:再生できるのは.wavのみです。
:************************************************************
:【③】圧縮形式
:Compression Format Setting
:

set compformat=7z

:圧縮形式を指定します。拡張子の.は不要です。
:対応形式は"7-Zip"が対応している
:  7z, XZ, BZIP2, GZIP, TAR, ZIP, WIM
:です。
:=============================================================
:
:処理終了時に音を鳴らす
:BEEP
:

set endwav="C:\Windows\Media\Ring03.wav"

:終了時に音を鳴らします。要らない場合は空にしてください。
:"～"で囲った形でフルパスで指定してください。
:形式について：Soxを使っていますが、wavでしか試していません。
:=============================================================
:
:Twitter向けモード
:TwitterMode
:

set twittermode=false

: true(有効)/false(無効)
:
:有効にするにはImageMagickが必要です。
:trueにすると以下のことを実行します。
: ① jpegにならないように、左上を少しだけ透過します。
: ② pngquantでファイルサイズを5MB以下に圧縮します。
:
:Twittermode処理完了後の画像はファイル名の先頭にfortwitter_が
:付きます。
:Twittermode処理前の画像も保存されます。
:=============================================================
:
:
:その他オプション(上級者用設定)
:
:          ↓ca(上)がcaffe co(中)がconverter-cpp
set otheropca01=
set otheropco01=
set otherop7z01=
:          ↑7z(下)が7-zip
:なにかご自分で指定したいオプションがあれば指定してください。
:コマンドプロンプトで打ち込む形で記入してください。
:ヒント:SoXはendwavに書き込めば適用されます。
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
echo 出力フォルダ:"!outfolder!"
echo ログ:"%logname%.log"
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
echo 出力フォルダ:"!outfolder!"
echo ログ:"%logname%.log"


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

:モード設定-自動倍数設定

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
 echo ImageMagickがインストールされていません。自動倍率計算とTwitterModeは無効です。
 echo ImageMagickがインストールされていません。自動倍率計算とTwitterModeは無効です。 >>"%logname%.log" 2>>&1
 echo ImageMagickのインストール方法はググってください。
 set scaleauto=false
 set twittermode=false
)
)
:next2

:モード設定-使用waifu
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
pushd "%~1" > NUL 2>&1
if errorlevel 1 (
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
 echo !DATE! !TIME! 設定した大きさに縮小します。 >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! 設定した大きさに縮小します。 
 call :reduction "%~1"
)

echo !DATE! !TIME! "%~nx1"の変換作業が正常に終了しました。 >>"%logname%.log" 2>>&1
echo 生成画像名:!mode01nam! >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~nx1"の変換作業が正常に終了しました。
echo 生成画像名:!mode01nam!

if "%twittermode%" == "true" (
 echo !DATE! !TIME! つづいて、twitter投稿用画像を作成します。 >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! つづいて、twitter投稿用画像を作成します。
 call %batdp%\twittermode.bat "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! twitter投稿用画像の作成が完了しました。 >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! twitter投稿用画像の作成が完了しました。
 echo 生成画像名:forTwitter_!mode01nam!
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
 echo !DATE! !TIME! 縮小だけ行います。 >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! 縮小だけ行います。
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
 echo !DATE! !TIME! 縮小だけ行います。 >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! 縮小だけ行います。
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

echo !DATE! !TIME! 倍率を自動計算します。 >>"%logname%.log" 2>>&1
echo !DATE! !TIME! 倍率を自動計算します。
CScript "%batdp%\script\multiplier.js" "%~1" %scaleauto_width01% %scaleauto_height01% "%multset_txt%" %accuracy% > NUL 2>&1
set /P scale_ratio01= < "%multset_txt%"
type NUL > "%multset_txt%
if !scale_ratio01! LEQ 1 (
echo !DATE! !TIME! 計算完了 : 拡大しません。
) else (
echo !DATE! !TIME! 計算完了 : %scale_ratio01%倍に拡大し、そこから縮小します。
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
echo !DATE! !TIME! "%~1"の変換を開始します... >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します...


if "!usewaifu:converter=!" NEQ "!usewaifu!" (
!usewaifu! --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "!outfolder!\!mode01nam!" %otheropco01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
!usewaifu! -p !process01! --model_dir ".\models\%model01%" !mode01var! -i "%~1" -o "!outfolder!\!mode01nam!" -l %inexli01% -e %ex:~1% %otheropca01% >>"%logname%.log" 2>>&1
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
echo %DATE% %TIME% "%~1"の処理を開始します...[フォルダモード]
if "%subf01%" == "true" (
 rem サブフォルダ処理モード
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
echo これで読み込まれた全ての画像の変換が完了しました。 >>"%logname%.log" 2>>&1
echo これで読み込まれた全ての画像の変換が完了しました。

call wta.bat STOP
call wta.bat PRINT >>"%logname%.log" 2>>&1
call wta.bat PRINT


if "%folderoutmode%" == "3" (
echo !DATE! !TIME! 7-ZIPで圧縮を開始します。
echo !DATE! !TIME! 7-ZIPで圧縮をしました。 >>"%logname%.log" 2>>&1
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

echo !DATE! !TIME! 7-ZIPで圧縮が完了しました。
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