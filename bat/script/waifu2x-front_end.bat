@echo off
set debug_hi=false
:===========================================================================================================================================
:準備
if "%1" == "" exit
Title %~nx0 : waifu2x now denoising!
setlocal enabledelayedexpansion
pushd "%~dp0"
pushd ..
set batdp=%CD%
pushd ..
Path=%PATH%;%CD%

set out_ext01=png
set thebat="%~0"
set batnx=%~nx0
set batnm=%~n0

set firstprocess=true
set process01=gpu

set multset_txt=%TMP%\mset-%batnm%.txt
set fname_txt=%TMP%\fset-%batnm%.txt

type NUL > "%multset_txt%"
type NUL > "%fname_txt%"

for /F "usebackq tokens=1-18" %%a in ( "%~1" ) do (
set mode01=%%a
rem auto_scale
if  "%debug_hi%" == "true" echo mode01 !mode01!

set model01=%%b
if  "%debug_hi%" == "true" echo model01 !model01!
rem anime_style_art_rgb

set scaleauto=%%c
if  "%debug_hi%" == "true" echo scaleauto !scaleauto!
rem false

set scaleauto_width01=%%d
rem 1920
if "!scaleauto_width01!" == "none" set scaleauto_width01=
if  "%debug_hi%" == "true" echo scaleauto_width01 !scaleauto_width01!

set scaleauto_height01=%%e
rem 1080
if "!scaleauto_height01!" == "none" set scaleauto_height01=
if  "%debug_hi%" == "true" echo scaleauto_height01 !scaleauto_height01!

set scale_ratio01=%%f
if  "%debug_hi%" == "true" echo scale_ratio01 !scale_ratio01!
rem 2

set noise_level01=%%g
if  "%debug_hi%" == "true" echo noise_level01 !noise_level01!
rem 2

set inexli01=%%h
if "!inexli01!" == "default" set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga
rem png:jpg:jpeg:tif:tiff:bmp:tga
if  "%debug_hi%" == "true" echo inexli01 !inexli01!

set subf01=%%i
rem true
if  "%debug_hi%" == "true" echo subf01 !subf01!

set usewaifu=%%j
rem waifu2x-converter
if "!usewaifu!" == "none" set usewaifu=
if "!usewaifu!" == "auto" set usewaifu=
if  "%debug_hi%" == "true" echo usewaifu  !usewaifu!

set folderoutmode=%%k
rem 2
if  "%debug_hi%" == "true" echo folderoutmode !folderoutmode!

set outfoldernameset=%%l
rem waifued
if  "%debug_hi%" == "true" echo outfoldernameset !outfoldernameset!

set compformat=%%m
rem 7z
if  "%debug_hi%" == "true" echo compfotmat !compformat!

set endwav=%%n
rem "C:\Windows\Media\Ring03.wav"
if "!endwav!" == "none" set endwav=
if  "%debug_hi%" == "true" echo endwav !endwav!

set twittermode=%%o
rem false
if  "%debug_hi%" == "true" echo twittermode !twittermode!

set alphaswitch=%%p
rem true
if  "%debug_hi%" == "true" echo alphaswitch !alphaswitch!

set otheropca11=%%~q
set otheropco11=%%~r
set otherop7z11=%%~s

if  "%debug_hi%" == "true" echo otheropca01 !otheropca01!
if  "%debug_hi%" == "true" echo otheropco01 !otheropco01!
if  "%debug_hi%" == "true" echo otherop7z01 !otherop7z01!

)

set otheropca01=%otheropca11:△=^ %
set otheropco01=%otheropco11:△=^ %
set otherop7z01=%otherop7z11:△=^ %
if  "%debug_hi%" == "true" echo %otheropco11% → %otheropco01%
if  "%debug_hi%" == "true" echo %otheropca11% → %otheropca01%
if "%otheropca11%" == "" (
 set otheropca01=
)
if "%otheropco11%" == "" (
 set otheropco01=
)
if "%otheropco11%" == "" (
 set otheropco01=
)

shift
if "%1" == "" goto end
if  "%debug_hi%" == "true" echo %1 %2 %3 %4 %5
if  "%debug_hi%" == "true" identify -format "%%w" %1
if  "%debug_hi%" == "true" pause
set scale_ratio02=%scale_ratio01%

:start
set hoge=*.%inexli01::= *.%

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
set outfoldercd=%TMP%\%batnm%\%outfoldernameset%
set outfolder=%TMP%\%batnm%\%outfoldernameset%
set lastzip=%~dp1\%outfoldernameset%.%compformat%
) else (
set outfolder=%~dp1\%outfoldernameset%
)

mkdir "!outfolder!" > NUL 2>&1
set logname=!outfolder!\w2xresult
echo %DATE% %TIME% Run %batnx% >>"%logname%.log" 2>>&1
echo 出力フォルダ:"!outfolder!"
echo ログ:"%logname%.log"
goto next1

:s_folder

if "%folderoutmode%" == "2" (
set outfoldercd=%~dp1%outfoldernameset%
set outfolder=%~dp1%outfoldernameset%
) else if "%folderoutmode%" == "3" (
set outfoldercd=%TMP%\%batnm%\%outfoldernameset%
set outfolder=%TMP%\%batnm%\%outfoldernameset%
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
 echo Error！！！ 0x10 >>"%logname%.log" 2>>&1
 echo Error！！！ 0x10
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

if not "%scale_ratio01%" == "%scale_ratio02%" (
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
 set jpegfile=true
 goto nam_a
 ) else if /I "%~x1" == ".jpeg" (
 set jpegfile=true
 goto nam_a
 ) else (
 set jpegfile=false
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
set scaling=true
if "%scaleauto%" == "true" (
set mode01nam=%~n1_waifu2x-noise_scale-%model01%-Lv%noise_level01%-%scaleauto_width01%x%scaleauto_height01%!exte!
) else (
set mode01nam=%~n1_waifu2x-noise_scale-%model01%-Lv%noise_level01%-!scale_ratio02!x!exte!
)
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONam

:nam_b

set scaling=false
set mode01nam=%~n1_waifu2x-noise-%model01%-Lv%noise_level01%!exte!
set mode01var=-m noise --noise_level %noise_level01%
goto EONam

:nam_c

set scaling=true
if "%scaleauto%" == "true" (
set mode01nam=%~n1_waifu2x-scale-%model01%-%scaleauto_width01%x%scaleauto_height01%!exte!
) else (
set mode01nam=%~n1_waifu2x-scale-%model01%-!scale_ratio02!x!exte!
)
set mode01var=-m scale --scale_ratio %scale_ratio01%
goto EONam

:EONam
goto end

:===========================================================================================================================================

:multiplier
if "%scaleauto%" == "true" (
echo !DATE! !TIME! 倍率を自動計算します。 >>"%logname%.log" 2>>&1
echo !DATE! !TIME! 倍率を自動計算します。
)
for /f %%x in ( 'identify -format ^"%%w^" %1' ) do (
set imagewidth=%%x
)
for /f %%y in ( 'identify -format ^"%%h^" %1' ) do (
set imageheight=%%y
)
CScript "%batdp%\script\multiplier.js" "%~1" %scaleauto_width01% %scaleauto_height01% "%multset_txt%" !imageheight! !imagewidth! %scaleauto% %scale_ratio02% > NUL 2>&1

set /P scale_ratio01= < "%multset_txt%"
type NUL > "%multset_txt%
if "%scaleauto%" == "true" (
if !scale_ratio01! LEQ 1 (
echo !DATE! !TIME! 計算完了 : 拡大しません。
) else (
echo !DATE! !TIME! 計算完了 : !scale_ratio01!倍に拡大し、そこから縮小します。
)
)

if "%scaleauto%" == "false" (
set /A "scaleauto_width01 = imagewidth * scale_ratio02"
set /A "scaleauto_height01 = imageheight * scale_ratio02"
)

goto end

:===========================================================================================================================================

:alpha

echo !DATE! !TIME! alpha情報の解析を行います...
echo !DATE! !TIME! alpha情報の解析を行います... >>"%logname%.log" 2>>&1

set whiteimage=%TMP%\white-%~n1.png
set blackimage=%TMP%\black-%~n1.png
set alphaimage=%TMP%\alpha-%~n1.png
set waifualpha_nam=waifualpha-%~n1.png
set waifualpha=%TMP%\%waifualpha_nam%
set sourcenoalpha_nam=noalphasource-%~n1.png
set sourcenoalpha=%TMP%\%sourcenoalpha_nam%
set waifuednoalpha_nam=waifuedsource-%~n1.png
set waifuednoalpha=%TMP%\%waifuednoalpha_nam%
set doingalpha=true

set debugmode=false

convert -size %imagewidth%x%imageheight% xc:white "!whiteimage!"
convert -size %imagewidth%x%imageheight% xc:black "!blackimage!"
composite -compose dst_out "%~1" "!blackimage!" -matte "!alphaimage!"
composite -compose over "!alphaimage!" "!whiteimage!" "!alphaimage!"
set CMD_IDENTIFY=identify -format "%%k" "!alphaimage!"
for /f "usebackq delims=" %%a in (`%CMD_IDENTIFY%`) do set image_mean=%%a

if "!image_mean!" == "1" (
echo !DATE! !TIME! alpha情報はありませんでした。 >>"%logname%.log" 2>>&1
echo !DATE! !TIME! alpha情報はありませんでした。
set alphais=false
) else (
echo !DATE! !TIME! alpha情報が見つかりました。
echo !DATE! !TIME! alpha情報が見つかりました。 >>"%logname%.log" 2>>&1
set alphais=true
convert "%~1" -background white -alpha deactivate -flatten "!sourcenoalpha!"
 echo alpha情報をwaifu2xで拡大します... >>"%logname%.log" 2>>&1
 echo alpha情報をwaifu2xで拡大します...
setlocal
set mode01var=-m scale --scale_ratio %scale_ratio01%
set outfolder=%TMP%
set mode01nam=!waifualpha_nam!
set otheropco=
set otheropca=
set twittermode=false
call :command_w2x "!alphaimage!"
endlocal
 echo !DATE! !TIME! 本体をwaifu2xで処理します... >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! 本体をwaifu2xで処理します...
setlocal
set outfolder=%TMP%
set mode01nam=!waifuednoalpha_nam!
set otheropco=
set otheropca=
set twittermode=false
call :command_w2x "!sourcenoalpha!"
endlocal
 echo !DATE! !TIME! alpha情報と本体を合成します...
 echo !DATE! !TIME! alpha情報と本体を合成します...  >>"%logname%.log" 2>>&1
composite "!waifualpha!" "!waifuednoalpha!" -alpha off -compose CopyOpacity "!outfolder!\!mode01nam!"
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
set allis=okay
if "%debugmode%" == "false" (
Del "!waifualpha!"
Del "!waifuednoalpha!"
Del "!sourcenoalpha!"
)
)
if "%debugmode%" == "false" (
Del "!whiteimage!"
Del "!blackimage!"
Del "!alphaimage!"
)
set doingalpha=false
goto end

:===========================================================================================================================================

:command_w2x
if "!usewaifu:converter=!" NEQ "!usewaifu!" (
!usewaifu! --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "!outfolder!\!mode01nam!" %otheropco01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
!usewaifu! -p !process01! --model_dir ".\models\%model01%" !mode01var! -i "%~1" -o "!outfolder!\!mode01nam!" -l %inexli01% -e png %otheropca01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else (
echo Error！！！ 0x00 >>"%logname%.log" 2>>&1
echo Error！！！ 0x00
exit /b
)

:===========================================================================================================================================


if "!w2xERROR!" GEQ "1" (
 if "!autochoosecc!" == "step1" (
  set usewaifu=waifu2x-converter_x64
  set autochoosecc=step2
  echo !DATE! !TIME! caffeでGPUでの変換を試みましたが、できませんでした。converterに移しその他のハードでの変換を開始します。 >>"%logname%.log" 2>>&1
  echo !DATE! !TIME! caffeでGPUでの変換を試みましたが、できませんでした。converterに移しその他のハードでの変換を開始します。
  goto command_w2x
 ) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
  if "!process01!" == "gpu" (
  set process01=cpu
  echo !DATE! !TIME! caffeでGPUでの変換を試みましたが、できませんでした。cpuで変換します。 >>"%logname%.log" 2>>&1
  echo !DATE! !TIME! caffeでGPUでの変換を試みましたが、できませんでした。cpuで変換します。
  goto command_w2x
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

goto end

:===========================================================================================================================================

:dow2x

echo.
echo. >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します... >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します...

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

call :multiplier "%~1"

call :namer "%~1"
if "!nowaifu!" == "true" exit /b
if "%alphaswitch%" == "true" (
if "%scaling%" == "true" (
if "%jpegfile%" == "false" (
call :alpha "%~1"
)
)
)
if "%allis%" == "okay" exit /b

call :command_w2x "%~1"

if "%AddICC%" == "true" (

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
pushd %batdp%
pushd ..
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

pushd %1
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
pushd %batdp%
pushd ..
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