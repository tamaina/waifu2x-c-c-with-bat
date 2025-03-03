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

set model01=anime_style_art

: anime_style_art (二次画像 輝度のみ)
: anime_style_art_rgb (二次画像 RGBで)
: photo (写真)
:=============================================================
:
:拡大率(+自動設定)[--scale_ratio]+[bat独自]
:About "scale_ratio"
:
:************************************************************
:【�@】自動倍率計算モードon/off
:Auto Calculate Magnification

set scaleauto=false

:拡大率を自動で計算してすべての画像の幅または高さをそろえます。
:true(有効)/false(無効)
:
:有効にする場合、ImageMagicが必要です。
:
:trueにした場合、必ず�A�Bの設定をしてください。
:falseにした場合、�Cの設定が適用されます。
:
:************************************************************
:【�A】目標幅
:Target Width

set scaleauto_width01=1920

:【�B】目標高さ
:Target Height

set scaleauto_height01=1080

:変換後のサイズを設定します(単位:px)。�Aは幅、�Bは高さです。
:両方を指定すると、両方の基準を満たす画像が作成されます。
:つまり、変換前の画像と�A�Bの縦横比が違った場合、
:変換前の画像の画像の短いほうが�A(�B)と同じになります。
:
:�A�Bのどちらかを0にすると、設定した方の基準で揃えます。
:両方を0にすると、scaleauto=falseと同じになります。
:
:入力画像が�A�Bでつくった長方形より大きかったときは、
:縮小します。
:************************************************************
:【�C】手動倍率設定[--scale_ratio]

set scale_ratio01=2

: 自動倍率計算が無効のときに使います。waifu2xのデフォルトです。
: ただし、2のwaifu2xでニの二乗倍で拡大し、それからimagemagickで
: 縮小します。

: 数字(単位:倍)小数点可。
:=============================================================
:
:ノイズ除去レベル[--noise_level]
:

set noise_level01=0

: 1,2,3 どれかを選択
: 1のほうが除去量が少なく現物に忠実です。
: 3になるにつれて除去量が多くなっていきます。
:=============================================================
:
:変換する拡張子[-l --input_extention_list]
:

set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga:gif:mp4:wmv:avi

: 区切り文字は " : "(コロン)。最後にはつけない
: 大文字小文字区別なし
:=============================================================
:
:動画を作るか、連番png出力でストップするか。
:

set ToMakeMovie=false

:true  →動画を作る(お手軽モード)
:false →連番pngを出力(上級者向け)
:falseにすると自分なりのアップコンバート動画が作れます。
:作られたpngはフォルダごと出力フォルダで指定したフォルダに移ります。
:=============================================================
:
:出力拡張子[-e --output_extention]
:
:

set OutputExtension=png

:いったんpngに変換されます。
:拡張子の前の.(ドット)は必要ありません。
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

set usewaifu=waifu2x-converter_x64

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
:【�@】出力フォルダモード
:Folder output mode setting

set folderoutmode=1

:以下の数字で指定してください。
:  0 →入力フォルダと同じフォルダに出力します。
:       �Aの設定は無視されます。
:  1 →�Aで指定した名前のフォルダが入力されたフォルダごとに
:       生成されます。
:  2 →�Aで指定した名前のフォルダが、一番最初に入力されたファイル
:       の上の階層につくられ、その中にまとめて画像が入ります。
:       もとのファイル構造は維持されます。
:  3 → 2 のフォルダを�Bで設定した形式に圧縮します。
:  4 → �Cで指定したフォルダに出力します。
:************************************************************
:【�A】出力フォルダ名
:Output folder name[This batch's own mode]
:

set outfoldernameset=waifued

:出力フォルダ名を指定します。
:使われ方は�@の設定によって異なります。
:再生できるのは.wavのみです。
:************************************************************
:【�B】圧縮形式
:Compression Format Setting
:

set compformat=7z

:圧縮形式を指定します。拡張子の.は不要です。
:対応形式は"7-Zip"が対応している
:  7z, XZ, BZIP2, GZIP, TAR, ZIP, WIM
:です。
:************************************************************
:【�C】フルパス指定
:Full Path Order
:

set outfolderbyFullpath=

:"〜"で囲わずに、フルパスで指定してください。
:
:=============================================================
:
:処理終了時に音を鳴らす
:BEEP
:

set endwav=

:終了時に音を鳴らします。要らない場合は空にしてください。
:"〜"で囲わずに、フルパスで指定してください。
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
: �@ jpegにならないように、左上を少しだけ透過します。
: �A pngquantでファイルサイズを3MB以下に圧縮します。
:
:Twittermode処理完了後の画像はファイル名の先頭にfortwitter_が
:付きます。
:Twittermode処理前の画像も保存されます。
:=============================================================
:
:Alpha情報をバッチファイルで操作する
:deal even alpha on this batchfile
:

set alphaswitch=true

:true(有効)/false(無効)
:falseにすると、画像がそのままwaifu2xに送られます。
:trueにすると、alpha情報を本体が分けてwaifu2xで処理します。
:
:きれいになる画像もあれば、汚くなる画像もあるため、画像との相性に
:注意して使い分けてください。

set AlphaBG=#000000

:上の設定では、透過部分の代わりに使用する色を指定します。
:☆指定方法
:  ・Webカラー 書式:#ffffff
:  ・RGB       書式:"rgb(255,255,255)"
:  ・色名      書式:white
:  ◎ImageMagickの色の指定です。
:=============================================================
:
:iccプロファイルを付与
:Add ICC Profile
:

set IccProf=

:拡張子iccのファイルをフルパスで"〜"で囲わず指定してください。
:(例)
: set IccProf=C:\Windows\System32\spool\drivers\color\AdobeRGB1998.icc
:
:バッチファイル内一律設定です。画像ごとの指定はできません。
:無効にする場合は空欄にします。
:=============================================================
:
:作業フォルダの設定
:Temporary Folder
:
:【モード設定】

set TMPFolderMode=b

: a →通常の%TMP%フォルダ
: b →出力フォルダと同じ
: c →↓で指定する

set outfolderbyFullpath=C:\Users\Takumiya_Cho\Desktop\dat\waifued

:フルパスで"〜"で囲わず指定してください。
:特殊なフォルダだとうまくできません。
:
:=============================================================
:
:
:その他オプション(上級者用設定)
:
:          ↓ca(上)がcaffe co(中)がconverter-cpp
set otheropca01=--tta 1
set otheropco01=
set otherop7z01=
set otheropff01=
:          ↑7z(下)が7-zip ffがFFmpeg
:なにかご自分で指定したいオプションがあれば指定してください。
:コマンドプロンプトで打ち込む形で記入してください。
:ヒント:SoXはendwavに書き込めば適用されます。
:=============================================================
:分割の計算にも対応したいなぁとか思ったり
:#############################################################
:諸注意
:#############################################################
:・出力画像名は
: [元画像名]_waifu2xco-[処理モード]-[モデル]-Lv[ノイズLv]-[拡大率]x.png
:  となります。
:
:（例）
:　　source_waifu2x-noise_scale-photo-Lv1-1280x1280.png
:
:
:この下から処理用のプログラムが始まります。
:=============================================================













































:===========================================================================================================================================
:準備
if "%~1" == "" exit
Title %~nx0 : waifu2x now denoising!
setlocal enabledelayedexpansion
set scale_ratio02=%scale_ratio01%
pushd "%~dp0"
pushd ..
Path=%PATH%;%CD%
popd
popd
cd /d "%~dp0"
cd ..

set out_ext01=png
set thebat="%~0"
set batdp=%~dp0
set batnx=%~nx0
set batnm=%~n0

set firstprocess=true
set process01=gpu


set multset_txt=%TMP%\mset-%batnm%.txt
set fname_txt=%TMP%\fset-%batnm%.txt

type NUL > "%multset_txt%"
type NUL > "%fname_txt%"

:start
set exte=.png
set per=%%
set hoge=*.%inexli01::= *.%
if "%TMPFolderMode%" == "c" (
set TMP=%TMPfoldernameset%
)
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
) else if "%folderoutmode%" == "4" (
set outfoldercd=%outfolderbyFullpath%
set outfolder=%outfolderbyFullpath%
) else (
set outfoldercd=%~dp1\%outfoldernameset%
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
) else if "%folderoutmode%" == "4" (
set outfolder=%outfolderbyFullpath%
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

:モード設定-自動倍数設定

if "%scaleauto%" == "true" (
 if "%scaleauto_width01%" == "0" (
  if "%scaleauto_height01%" == "0" (
  set scaleauto=false
  )
 )
)

if "%scaleauto%" == "true" (
magick identify -help > NUL 2>&1
if errorlevel 2 (
 echo ImageMagickがインストールされていないか、バージョンアップがされていません。インストールをお願いします。
 echo ImageMagickがインストールされていません。バージョンアップがされていません。インストールしてください。 >>"%logname%.log" 2>>&1
 echo なお、ImageMagickのインストール方法はググってください。
 pause
 exit
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
echo -------------------------------------------
echo ------------------------------------------- >>"%logname%.log" 2>>&1
 goto w2x_folder
 ) else if "%folder%" == "false" (
echo -------------------------------------------
echo ------------------------------------------- >>"%logname%.log" 2>>&1
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
magick mogrify -resize x%scaleauto_height01% "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
) else if %scaleauto_width01% GTR %scaleauto_height01% (
magick mogrify -resize %scaleauto_width01%x "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
)
goto end

:noexpant
if "!scale_ratio01!" == "0" (
magick convert "%~1" -resize x%scaleauto_height01% "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
) else if "!scale_ratio01!" == "1" (
magick convert "%~1" -resize %scaleauto_width01%x "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
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

goto end

:===========================================================================================================================================

:namer

if !scale_ratio01! LEQ 1 goto nam_noiseorno
if "%mode01%" == "auto_scale" goto nam_auto
if "%mode01%" == "noise_scale" goto nam_a
if "%mode01%" == "noise" goto nam_b
if "%mode01%" == "scale" goto nam_c


:nam_auto
if "!jpegfile!" == "true" (
 goto nam_a
 ) else (
 goto nam_c
 )
:nam_noiseorno
if "%mode01%" == "auto_scale" (
if "!jpegfile!" == "true" (
 goto nam_b
 ) else (
 set nowaifu=true
 set "mode01nam=%~n1_reduced!exte!"
 echo !DATE! !TIME! 縮小だけ行います。 >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! 縮小だけ行います。
 call :success "%~1"
 call wtb.bat STOP
 echo. >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo.
 call wtb.bat PRINT
 exit /b
 )
) else (
 set nowaifu=true
 set "mode01nam=%~n1_reduced!exte!"
 echo !DATE! !TIME! 縮小だけ行います。 >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! 縮小だけ行います。
 call :success "%~1"
 call wtb.bat STOP
 echo. >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo.
 call wtb.bat PRINT
 exit /b
)
:nam_a
set scaling=true
if "%scaleauto%" == "true" (
set "mode01nam=%~n1_waifu2x-noise_scale-%model01%-Lv%noise_level01%-%scaleauto_width01%x%scaleauto_height01%!exte!"
) else (
set "mode01nam=%~n1_waifu2x-noise_scale-%model01%-Lv%noise_level01%-!scale_ratio02!x!exte!"
)
set "mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%"
goto EONam

:nam_b

set scaling=false
set "mode01nam=%~n1_waifu2x-noise-%model01%-Lv%noise_level01%!exte!"
set "mode01var=-m noise --noise_level %noise_level01%"
goto EONam

:nam_c

set scaling=true
if "%scaleauto%" == "true" (
set "mode01nam=%~n1_waifu2x-scale-%model01%-%scaleauto_width01%x%scaleauto_height01%!exte!"
) else (
set "mode01nam=%~n1_waifu2x-scale-%model01%-!scale_ratio02!x!exte!"
)
set "mode01var=-m scale --scale_ratio %scale_ratio01%"
goto EONam

:EONam
goto end

:===========================================================================================================================================

:multiplier
if "%scaleauto%" == "true" (
echo !DATE! !TIME! 倍率を自動計算します。 >>"%logname%.log" 2>>&1
echo !DATE! !TIME! 倍率を自動計算します。
)
for /f %%x in ( 'magick identify -format "%%w\n" "%~1"' ) do (
set imagewidth=%%x
)
for /f %%y in ( 'magick identify -format "%%h\n" "%~1"' ) do (
set imageheight=%%y
)
CScript "%batdp%\script\multiplier.js" "%~1" %scaleauto_width01% %scaleauto_height01% "%multset_txt%" !imageheight! !imagewidth! %scaleauto% %scale_ratio02% > NUL 2>&1

set /P scale_ratio01= < "%multset_txt%"
type NUL > "%multset_txt%
if "%scaleauto%" == "true" (
if not !scale_ratio01! LEQ 1 (
echo !DATE! !TIME! 計算完了 : !scale_ratio01!倍に拡大し、そこから縮小します。
)
)

if "%scaleauto%" == "false" (
set /A "scaleauto_width01 = imagewidth * scale_ratio02"
set /A "scaleauto_height01 = imageheight * scale_ratio02"
echo !DATE! !TIME! 計算完了 : !scale_ratio01!倍に拡大し、そこから縮小します。
)

goto end

:===========================================================================================================================================

:alpha

echo !DATE! !TIME! alpha情報の解析を行います...
echo !DATE! !TIME! alpha情報の解析を行います... >>"%logname%.log" 2>>&1

set whiteimage=%TMP%\white-%~n1.png
set blackimage=%TMP%\black-%~n1.png
set colorbase=%TMP%\base-%~n1.png
set alphaimage=%TMP%\alpha-%~n1.png
set waifualpha_nam=waifualpha-%~n1.png
set waifualpha=%TMP%\!waifualpha_nam!
set sourcewoalpha_nam=woalphasource-%~n1.png
set sourcewoalpha=%TMP%\!sourcewoalpha_nam!
set sourcenoalpha_nam=noalphasource-%~n1.png
set sourcenoalpha=%TMP%\!sourcenoalpha_nam!
set waifuednoalpha_nam=waifuedsource-%~n1.png
set waifuednoalpha=%TMP%\!waifuednoalpha_nam!
set doingalpha=true

set debugmode=false

magick convert -size !imagewidth!x!imageheight! xc:white "!whiteimage!"
magick convert -size !imagewidth!x!imageheight! xc:black "!blackimage!"
magick convert -size !imagewidth!x!imageheight! xc:%AlphaBG% "!colorbase!"
magick composite -compose dst_out "%~1" "!blackimage!" -matte "!alphaimage!"
magick composite -compose over "!alphaimage!" "!whiteimage!" "!alphaimage!"
set CMD_IDENTIFY=magick identify -format "%%k" "!alphaimage!"
for /f "usebackq delims=" %%a in (`!CMD_IDENTIFY!`) do set image_mean=%%a

if "!image_mean!" == "1" (
echo !DATE! !TIME! alpha情報はありませんでした。 >>"%logname%.log" 2>>&1
echo !DATE! !TIME! alpha情報はありませんでした。
set alphais=false
) else (
echo !DATE! !TIME! alpha情報が見つかりました。
echo !DATE! !TIME! alpha情報が見つかりました。 >>"%logname%.log" 2>>&1
set alphais=true
magick convert "%~1" -background %AlphaBG% -alpha off "!sourcenoalpha!"
 echo alpha情報をwaifu2xで拡大します... >>"%logname%.log" 2>>&1
 echo alpha情報をwaifu2xで拡大します...
setlocal
set mode01var=-m scale --scale_ratio !scale_ratio01!
set outfolder=%TMP%
set mode01nam=!waifualpha_nam!
set twittermode=false
call :command_w2x "!alphaimage!"
endlocal
if /I "!GifFlag!" == "true" (
magick identify "!waifualpha!" -threshold 50%% "!waifualpha!"
)

 echo !DATE! !TIME! 本体をwaifu2xで処理します... >>"%logname%.log" 2>>&1
 echo !DATE! !TIME! 本体をwaifu2xで処理します...
setlocal
set outfolder=%TMP%
set mode01nam=!waifuednoalpha_nam!
set twittermode=false
call :command_w2x "!sourcenoalpha!"
endlocal

 echo !DATE! !TIME! alpha情報と本体を合成します...
 echo !DATE! !TIME! alpha情報と本体を合成します...  >>"%logname%.log" 2>>&1
magick composite "!waifualpha!" "!waifuednoalpha!" -alpha off -compose CopyOpacity png32:"!outfolder!\!mode01nam!"
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
set allis=true
if "!debugmode!" == "false" (
Del "!waifualpha!"
Del "!waifuednoalpha!"
Del "!sourcenoalpha!"

Del "!whiteimage!"
Del "!blackimage!"
Del "!alphaimage!"
)
)
set doingalpha=false
goto end
:===========================================================================================================================================
:gifname
set GifPath=%~dpn1.gif
goto end
:===========================================================================================================================================

:animation

set TMP_ANM=%TMP%\%~n1-anm
set wfd_folder=%TMP%\%~n1-anm-waifued
set Serialed_Picture=!TMP_ANM!\%~n1
set ffmpeg_txt=%TMP%\w2xffmpeg.txt
mkdir "!TMP_ANM!" > NUL 2>&1

if /I "%~x1" == ".gif" (
magick convert +adjoin -background none "%~1" "!Serialed_Picture!-%%012d.png"
) else (
ffmpeg -i "%~1" -f image2 -vcodec png "!Serialed_Picture!-%%012d.png" > "!ffmpeg_txt!" 2>&1
)
set number=0
for /F "delims=" %%a in ( 'dir /B "!TMP_ANM!\*.png"' ) do (
set /A "number = number + 1"
)
if !number! GTR 1 (
set animation=true
mkdir "!wfd_folder!" > NUL 2>&1
) else (
set animation=false
Del /Q "!TMP_ANM!" > NUL 2>&1
type NUL > "!ffmpeg_txt!" > NUL 2>&1
exit /b
)
if /I "%~x1" == ".gif" (
echo アニメーションGIFを入力しました。画像枚数が多いと処理に時間がかかりますが、よろしいですか？
echo !TIME! 操作がなければ1分後に開始します...
set anmMode=GIF
set GifFlag=true
) else (
echo 動画ファイルを入力しました。フレーム数が多いとハードウェアに負担がかかりますが、よろしいですか？
echo 処理速度は大丈夫ですか？グラボを積んでいないときついです。
echo ハードディスク容量は大丈夫ですか？png出力とはいえ無尽蔵に容量を食っていきます。
echo !TIME! 操作がなければ1分後に開始します...
set anmMode=MOV
set animation=true
)
Choice /T 60 /D Y /N /M "Y:すぐ続ける N:やめる"
if errorlevel 2 (
set stopandnext=true
exit /b
)

echo.
echo. >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します... >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します...
set stopandnext=false
if "%folderoutmode%" == "0" (
set outfolder=%~dp1
) else if "%folderoutmode%" == "1" (
set outfolder=%~dp1\%outfoldernameset%
)
if "%TMPFolderMode%" == "b" (
set TMP=!outfolder!
)
call :multiplier "!Serialed_Picture!-000000000001.png"
set exte02=%exte%
set exte=%~x1
call :namer "%~1"
set exte=!exte02!


set fps_txt=%TMP%\w2xfps.txt
type NUL > "!ffmpeg_txt!"
type NUL > "!fps_txt!"
CScript "%batdp%\script\extract-fps.js" "!ffmpeg_txt!" "!fps_txt!" > NUL 2>&1
set /P FPS= < "!fps_txt!"
type NUL > "!ffmpeg_txt!"
type NUL > "!fps_txt!"

if /I "%~x1" == ".gif" (
for /F "delims=" %%t in ( 'magick identify -format "%%T\n" "%~1"' ) do (
set FPS=%%t
)
set identify_txt=%TMP%\w2xident.txt
set transparent_txt=%TMP%\w2xtp.txt
type NUL > "!identify_txt!"
type NUL > "!transparent_txt!"
magick identify -verbose "%~1" > "!identify_txt!" 2>&1
CScript "%batdp%\script\extract-transparent.js" "!identify_txt!" "!transparent_txt!" > NUL 2>&1
set /P transparent= < "!transparent_txt!"
type NUL > "!identify_txt!"
type NUL > "!transparent_txt!"
)

setlocal
set outfolder=!wfd_folder!
set twittermode=false
if "!anmMode!" == "GIF" (
set /A "number = number - 1"
)
:anm_loop
if !number! LEQ 9 (
set renban=00000000000!number!
) else if !number! LEQ 99 (
set renban=0000000000!number!
) else if !number! LEQ 999 (
set renban=000000000!number!
) else if !number! LEQ 9999 (
set renban=00000000!number!
) else if !number! LEQ 99999 (
set renban=0000000!number!
) else if !number! LEQ 999999 (
set renban=000000!number!
) else if !number! LEQ 9999999 (
set renban=00000!number!
) else if !number! LEQ 99999999 (
set renban=0000!number!
) else if !number! LEQ 999999999 (
set renban=000!number!
) else if !number! LEQ 9999999999 (
set renban=00!number!
) else if !number! LEQ 99999999999 (
set renban=0!number!
) else if !number! LEQ 999999999999 (
set renban=!number!
)

set mode01nam=wfd_%~n1-!renban!.png
if /I not "!anmMode!" == "GIF" (
if /I not "%~x1" == ".avi" (
if "%mode01%" == "scale" (
set mode01var=-m scale --scale_ratio %scale_ratio01%
) else if "%mode01%" == "noise" (
set mode01var=-m noise --noise_level %noise_level01%
) else (
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
)
)
)
if "!anmMode!" == "GIF" (
call :alpha "!Serialed_Picture!-!renban!.png"
goto anm_end_for
)
call :command_w2x "!Serialed_Picture!-!renban!.png"
:anm_end_for
set /A "number = number - 1"
if "!anmMode!" == "GIF" (
if !number! GEQ 0 goto anm_loop
) else (
if !number! GEQ 1 goto anm_loop
)
set allis=true
endlocal

if "!anmMode!" == "GIF" (
if "%ToMakeMovie%" == "true" (
magick convert -dispose previous -delay !FPS! -loop 0 "!wfd_folder!\wfd_%~n1-*.png" "!outfolder!\!mode01nam!"
echo !DATE! !TIME! "%~nx1"の変換作業が終了しました。 >>"%logname%.log" 2>>&1
echo 生成画像名:!mode01nam! >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~nx1"の変換作業が終了しました。
) else (
call :noext "!outfolder!\!mode01nam!"
move "!wfd_folder!" "!NoExtPath!" /Y /I > NUL 2>&1
echo NUL > "!NoExtPath!\!FPS!fps.txt"
echo !DATE! !TIME! "%~nx1"の変換作業が終了しました。 >>"%logname%.log" 2>>&1
echo 連番画像生成先フォルダ:!NoExtPath! >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~nx1"の変換作業が終了しました。
echo -------------------------------------------
echo ------------------------------------------- >>"%logname%.log" 2>>&1
)
) else (
if "%ToMakeMovie%" == "true" (
ffmpeg -i "!wfd_folder!\wfd_%~n1-%%012d.png" -r !FPS! %otheropff01% "!outfolder!\!mode01nam!"
echo !DATE! !TIME! "%~nx1"の変換作業が終了しました。 >>"%logname%.log" 2>>&1
echo 生成動画名:!mode01nam! >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~nx1"の変換作業が終了しました。
echo -------------------------------------------
echo ------------------------------------------- >>"%logname%.log" 2>>&1
) else (
call :noext "!outfolder!\!mode01nam!"
move "!wfd_folder!" "!NoExtPath!" /Y /I > NUL 2>&1
echo NUL > "!NoExtPath!\!FPS!fps.txt"
echo !DATE! !TIME! "%~nx1"の変換作業が終了しました。 >>"%logname%.log" 2>>&1
echo 連番画像生成先フォルダ:!NoExtPath! >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "%~nx1"の変換作業が終了しました。
echo -------------------------------------------
echo ------------------------------------------- >>"%logname%.log" 2>>&1
)
)
Del /Q !TMP_ANM! > NUL 2>&1
Del /Q !wfd_folder! > NUL 2>&1
 call wtb.bat STOP
 echo. >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo.
 call wtb.bat PRINT
set allis=true

goto end
:===========================================================================================================================================

:command_w2x
if "!usewaifu:converter=!" NEQ "!usewaifu!" (
!usewaifu! --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "!outfolder!\!mode01nam!" %otheropco01% >>"%logname%.log" 2>>&1
set w2xERROR=!ERRORLEVEL!
) else if "!usewaifu:caffe=!" NEQ "!usewaifu!" (
!usewaifu! -p !process01! --model_dir ".\models\%model01%" !mode01var! -i "%~1" -o "!outfolder!\!mode01nam!" -l %inexli01% -e %OutputExtension% %otheropca01% >>"%logname%.log" 2>>&1
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

if "%folderoutmode%" == "0" (
set outfolder=%~dp1
) else if "%folderoutmode%" == "1" (
set outfolder=%~dp1\%outfoldernameset%
)
if "%TMPFolderMode%" == "b" (
set TMP=!outfolder!
)
mkdir "!outfolder!" > NUL 2>&1

call :multiplier "%~1"
call :namer "%~1"
if "!nowaifu!" == "true" exit /b
if "%alphaswitch%" == "true" (
if "%scaling%" == "true" (
call :alpha "%~1"
)
)
if "!allis!" == "true" exit /b

call :command_w2x "%~1"

 call wtb.bat STOP
 echo. >>"%logname%.log" 2>>&1
 call wtb.bat PRINT >>"%logname%.log" 2>>&1
 echo.
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

:LongFilePath
for /f "delims=" %%p in ( 'call "%batdp%\longname.bat" "%~1"' ) do (
set FileName=%%p
)
set FilePath=%~dp1!FileName!

goto end
:===========================================================================================================================================
:noext
set NoExtPath=%~dpn1
goto end
:===========================================================================================================================================

:shimatsu
if /I not "%~x1" == ".png" (
Del "!PngFilePath!" > NUL 2>&1
)
call :noext !outfolder!\!mode01nam!
if not "%OutputExtension%" == "png" (

 if "%OutputExtension%" == "false" (
 magick convert "!outfolder!\!mode01nam!" "!NoExtPath!%~x1"
 if /I not "%~x1" == ".png" del "!outfolder!\!mode01nam!" > NUL 2>&1
 ) else (
 magick convert "!outfolder!\!mode01nam!" "!NoExtPath!.%OutputExtension%"
 del "!outfolder!\!mode01nam!" > NUL 2>&1
 )
if not "%IccProf%" == "" (
magick convert "!outfolder!\!mode01namwoex!.%OutputExtension%" -profile "%IccProf%" "!NoExtPath!.%OutputExtension%" >>"%logname%.log" 2>>&1
)

) else (
if not "%IccProf%" == "" (
magick convert "!outfolder!\!mode01nam!" -profile "%IccProf%" "!outfolder!\!mode01nam!" >>"%logname%.log" 2>>&1
)
)

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

:toPng
if /I not "%~x1" == ".png" (
set Pngtf=false
magick convert "%~1" "%~dpn1.png"
if /I "%~x1" == ".jpg" (
 set jpegfile=true
 ) else if /I "%~x1" == ".jpeg" (
 set jpegfile=true
 ) else (
 set jpegfile=false
 )
) else (
set Pngtf=true
)
set PngFilePath=%~dpn1.png
goto end
:===========================================================================================================================================

:w2x_file
pushd %batdp%
pushd ..
call wtb.bat START
:inexli01にあってるか確認する
call :LongFilePath "%~1"
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
 echo "!FileName!"を読み込みましたが、バッチファイルで指定された拡張子の中に"%~x1"がなかったため変換しません。 >>"%logname%.log" 2>>&1
 echo "!FileName!"を読み込みましたが、バッチファイルで指定された拡張子の中に"%~x1"がなかったため変換しません。
 goto nextforex
 )
:okayex
if "%folderoutmode%" == "2" (
call :outfilename_a "%~1"
) else if "%folderoutmode%" == "3" (
call :outfilename_a "%~1"
) else if "%folderoutmode%" == "4" (
call :outfilename_a "%~1"
)

call :animation "!FilePath!"
if "!allis!" == "true" (
shift
goto nextforex
)
call :toPng "!FilePath!"
echo.
echo. >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "!FilePath!"の変換を開始します... >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "!FilePath!"の変換を開始します...
call :dow2x "!PngFilePath!"
call :shimatsu "!FilePath!"

:nextforex
shift
if "%~1" == "" goto Finish_w2x
goto shiwake

:===========================================================================================================================================
:w2x_folder

pushd %1
echo %DATE% %TIME% "%~1"の処理を開始します...[フォルダモード]
echo %DATE% %TIME% "%~1"の処理を開始します...[フォルダモード] >>"%logname%.log" 2>>&1

set folderpath=%~1
if "%subf01%" == "true" (
 rem サブフォルダ処理モード
 for /f "delims=" %%t in ( 'dir %hoge% /A /B /S' ) do (
  set filepath=%%~st
  call :w2xf1 !filepath! true "%folderpath%"
  )
 ) else (
 for /f "delims=" %%t in ( 'dir %hoge% /A /B' ) do (
  set filepath=%~s1\%%~snxt
  call :w2xf1 !filepath!
  )
 )
echo %DATE% %TIME% "%~1"の処理が終了しました。[フォルダモード]
echo %DATE% %TIME% "%~1"の処理が終了しました。[フォルダモード] >>"%logname%.log" 2>>&1
shift
if "%~1" == "" goto Finish_w2x
goto shiwake
 
:w2xf1
popd
pushd %batdp%
pushd ..
call wtb.bat START

call :LongFilePath %1

set cafname=!FileName!
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
) else if "%folderoutmode%" == "4" (
if "%2" == "true" (
call :outfilename_b "%~1" "%~3"
) else (
call :outfilename_a "%~1"
)
)
call :animation "!FilePath!"
if "!allis!" == "true" exit /b

call :toPng "!FilePath!"
echo.
echo. >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "!FilePath!"の変換を開始します... >>"%logname%.log" 2>>&1
echo !DATE! !TIME! "!FilePath!"の変換を開始します...
call :dow2x "!PngFilePath!"
call :shimatsu "!FilePath!"
goto end
:===========================================================================================================================================

:Finish_w2x
echo Finish: %batnx% >>"%logname%.log" 2>>&1
echo これで読み込まれた全ての画像の変換が完了しました。 >>"%logname%.log" 2>>&1
echo これで読み込まれた全ての画像の変換が完了しました。

call wta.bat STOP
call wta.bat PRINT >>"%logname%.log" 2>>&1
call wta.bat PRINT


if "%folderoutmode%" == "3" (
echo !DATE! !TIME! 7-ZIPで圧縮を開始します。
echo !DATE! !TIME! 7-ZIPで圧縮をしました。 >>"%logname%.log" 2>>&1
echo . >>"%logname%.log" 2>&1
echo . >>"%logname%.log" 2>&1
echo . >>"%logname%.log" 2>&1
echo . >>"%logname%.log" 2>&1
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
7za64 a "%lastzip%" "%outfoldercd%" %otherop7z01%
) else (
7za a "%lastzip%" "%outfoldercd%"%otherop7z01%
)

echo !DATE! !TIME! 7-ZIPで圧縮が完了しました。
echo "%lastzip%"
rd /S /Q "%outfoldercd%" > NUL 2>&1
) else (
echo . >>"%logname%.log" 2>&1
echo . >>"%logname%.log" 2>&1
echo . >>"%logname%.log" 2>&1
echo . >>"%logname%.log" 2>&1
)

Del "%multset_txt%"
Del "%fname_txt%"

set AUDIODRIVER=waveaudio
if not "%endwav%" == "" (
play "%endwav%"
)

pause
exit
:end