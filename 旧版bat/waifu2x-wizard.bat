@echo off
:=============================================================
:#############################################################
:説明
:#############################################################
: ウィザードモードです
:waifuの設定はbatに直接書くのではなく、
:このbatを実行して設定してください。
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
:以下は選択オプションの選択肢の設定を兼ねたウィザードの
:実行コードです。弄るのは上級者向け？
:=============================================================
:
:待ち時間
:

set waitingtime=60

: 秒
:=============================================================
:
:出力フォルダ名初期値
:

set outfolder=waifued

: 初期値です
:=============================================================



:choice000
choice /N /C AB /T %waitingtime% /D B /M "[model]モデルを選択[A:anime_style_art_rgb(アニメなど)/B:photo(写真など)]"
if errorlevel 2 (
 set model01=photo
 echo -photo(写真)
 goto choice00
 )
 set model01=anime_style_art_rgb
 echo -anime_style_art_rgb(アニメなど)
:choice00
choice /C YN /T %waitingtime% /D Y /M "[usew2x]caffe/converter-cppどちらを使用するか自動で決定しますか"
if "%errorlevel%" == "1" (
 echo -指定する
 goto choice01
 ) else (
 echo -指定しない
 set ccchoice=
 )
choice /N /C AP /T %waitingtime% /D A /M "[usew2x]では、caffe/converter-cppどちらを使用しますか[A:caffe,P:cpp]?"
if errorlevel 2 (
 set ccchoice=cpp
 echo -cppバージョン
 ) else (
 set ccchoice=caffe
 echo -caffeバージョン
 )

:choice01
choice /C YN /T %waitingtime% /D Y /M "[auto_scale]ノイズ除去機能はjpeg画像のみで作動させますか"
if errorlevel 2 goto choice02
echo -する
set mode01=auto_scale
goto choice02kakunin

:choice02
choice /C YN /T %waitingtime% /D Y /M "[noise]ノイズを除去しますか"
if errorlevel 2 (
 set noisechoice=no
 echo -しない
 goto choice02a
 )
set noisechoice=yes
echo -する
choice /N /C 12 /T %waitingtime% /D Y /M "[noise_level]ノイズ除去レベルを入力[1/2]"
set noise_level=%errorlevel%

:choice02a
choice /C YN /T %waitingtime% /D Y /M "[scale]拡大しますか"
if errorlevel 2 (
 set scalechoice=no
 echo -しない
 goto choicetovarm
 )
set scalechoice=yes
echo -する
set /P scale_ratio01=拡大率を半角数字で入力[小数可]:

:choicetovarm

if "%noisechoice%" == "no" (
 if "%scalechoice%" == "yes" (
 set mode01=scale
 if "%scalechoice%" == "no" (
 echo .
 echo 何もさせない気ですか？なら開いた意味ないじゃないですか。もう一回モード設定をやり直してきてください。
 echo .
 goto choice01
 )
 ) else (
 if "%scalechoice%" == "yes" (
 set mode01=noise_scale
 if "%scalechoice%" == "no" (
 set mode01=noise
 )

:choice02kakunin
choice /N /C YFN /T %waitingtime% /D Y /M "[確認]waifu2x動作モードは%mode01%です。よろしいですか[Y:次へ,N:モード設定からやり直し,F:最初からやり直す]?"
if errorlevel 3 goto choice02
if errorlevel 2 goto choice00

:choice03
choice /C YN /T %waitingtime% /D Y /M "[bat独自]フォルダを処理するとき、サブフォルダを処理しますか"
if errorlevel 2 (
 echo -しない
 set subf01=false
 ) else ( 
 echo -する
 set subf01=true
 )

:choice04
choice /N /C YN /T %waitingtime% /D Y /M "基本設定は終わりです。これで処理を開始しますがよろしいですか[Y,N]?Nを選択するとより詳細な設定に移ります。"
if "%errorlevel%" == "1" goto finishchoosing
:choice05
choice /C YN /T %waitingtime% /D N /M "[caffe]出力時の拡張子を指定しますか[デフォルト値:png]"
if errorlevel 2 (
 echo -しない
 set out_ext01=png
 goto choice06
 )
 echo -する
set /P out_ext01=出力画像の拡張子を入力("."は要りません)

:choice06
choice /C YN /T %waitingtime% /D N /M "[caffe]入力する画像の拡張子を指定しますか[デフォルト値→png:jpg:jpeg:tif:tiff:bmp:tga]"
if errorlevel 2 (
 echo -しない
 set inexli01=png:jpg:jpeg:tif:tiff:bmp:tga
 goto choice06a
 )
 echo -する
set /P inexli01=入力画像の拡張子を入力("."は要りません/":"で区切ります/"端"は区切り記号を【入れません】)

:choice06a
choice /C YN /T %waitingtime% /D N /M "[共通]出力フォルダ名を変更しますか？ 初期値:%outfolder%(batを直接開いて変更可)"

if errorlevel 2 (
 echo -しない
 goto choice07
 )
 echo -する
set /P outfolder=出力フォルダ名変更(何も書かないと同じフォルダに出力します)

:choice07
echo 以上で設定は終わりです。
choice /C YN /T %waitingtime% /D Y /M "処理を開始しますか？Nを押すと最初から設定します。"
if errorlevel 2 goto choice00


:finishchoosing
echo %~1


:準備

setlocal enabledelayedexpansion
set process01=gpu
set datcdd=%~d0
set datcdp=%~p0
set datcdn=%~n0
goto ffjudge

:restart
if "%~1" == "" goto Finish_w2x


:ffjudge

pushd %~1
set pushderrorlv=%ErrorLevel%
if "%pushderrorlv%" GEQ "1" (
 set folder=false
 goto s_file
) else (
 popd
 set folder=true
 goto s_folder
)

:s_file

mkdir %~dp1\%outfolder%
set logname=%~dp1\%outfolder%\w2xresult
echo %DATE% %TIME% ファイルモード
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [ファイルモード] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dp1\%outfolder%"を作成
echo %DATE% %TIME% "%logname%.log"を作成(すでにある場合は追記します。)
cd /d %datcdd%%datcdp% >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
goto next1

:s_folder

mkdir %~dpn1\%outfolder%
set logname=%~dpn1\%outfolder%\w2xresult
echo %DATE% %TIME% フォルダモード
echo %DATE% %TIME% Run %datcdn%.bat(%datcdd%%datcdp%) [フォルダモード] >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~dpn1\%outfolder%"を作成
echo %DATE% %TIME% "%logname%.log"を作成(すでにある場合は追記します。)
cd /d %datcdd%%datcdp% >>%logname%.log 2>>&1
cd .. >>%logname%.log 2>>&1
if "%usewaifu%" == "true" (
 goto next1
 ) else if "%usewaifu%" == "waifu2x-converter_x64" (
 goto w2xco_folder
 ) else if "%usewaifu%" == "waifu2x-converter" (
 goto w2xco_folder
 ) else (
 goto w2xca_folder
 )


:next1

call wta.bat START

:CPU検出
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
 if "%ccchoice%" == "caffe" (
 set usewaifu=waifu2x-caffe
 echo %DATE% %TIME% 64bitCPUを検出しました。waifu2x-caffeで処理します。
 echo %DATE% %TIME% 64bitCPUを検出しました。waifu2x-caffeで処理します。 >>%logname%.log 2>>&1
 if "%folder%" == "true" (
  echo %DATE% %TIME% フォルダモード >>%logname%.log 2>>&1
  echo %DATE% %TIME% フォルダモード
  goto w2xca_folder
  ) else (
  echo %DATE% %TIME% ファイルモード >>%logname%.log 2>>&1
  echo %DATE% %TIME% ファイルモード
  goto w2xca_file
  )
 ) else if "%ccchoice%" == "cpp" (
set usewaifu=waifu2x-converter_x64
 echo %DATE% %TIME% 64bitCPUを検出しました。waifu2x-converter_x64で処理します。
 echo %DATE% %TIME% 64bitCPUを検出しました。waifu2x-converter_x64で処理します。 >>%logname%.log 2>>&1
  if "%folder%" == "true" (
  echo %DATE% %TIME% フォルダモード >>%logname%.log 2>>&1
  echo %DATE% %TIME% フォルダモード
  goto w2xco_folder
  ) else (
  echo %DATE% %TIME% ファイルモード >>%logname%.log 2>>&1
  echo %DATE% %TIME% ファイルモード
  goto w2xco_file
  )
 ) else (
 set usewaifu=waifu2x-caffe
 echo %DATE% %TIME% 64bitCPUを検出しました。はじめにwaifu2x-caffeで処理します。
 echo %DATE% %TIME% 64bitCPUを検出しました。はじめにwaifu2x-caffeで処理します。 >>%logname%.log 2>>&1
  if "%folder%" == "true" (
  echo %DATE% %TIME% フォルダモード >>%logname%.log 2>>&1
  echo %DATE% %TIME% フォルダモード
  goto w2xca_folder
  ) else (
  echo %DATE% %TIME% ファイルモード >>%logname%.log 2>>&1
  echo %DATE% %TIME% ファイルモード
  goto w2xca_file
  )
 )
 ) else (
 set usewaifu=waifu2x-converter
echo %DATE% %TIME% 32bitCPUを検出しました。
echo %DATE% %TIME% 32bitCPUを検出しました。 >>%logname%.log 2>>&1
 if "%ccchoice%" == "caffe" (
 echo caffe版は32bit版では使えません。32bit版waifu2x-converterで処理します。
 echo caffe版は32bit版では使えません。32bit版waifu2x-converterで処理します。 >>%logname%.log 2>>&1
 ) else (
 echo 32bit版waifu2x-converterで処理します。 >>%logname%.log 2>>&1
 echo 32bit版waifu2x-converterで処理します。 >>%logname%.log 2>>&1
 )
  if "%folder%" == "true" (
  echo %DATE% %TIME% フォルダモード >>%logname%.log 2>>&1
  echo %DATE% %TIME% フォルダモード
  goto w2xco_folder
  ) else (
  echo %DATE% %TIME% ファイルモード >>%logname%.log 2>>&1
  echo %DATE% %TIME% ファイルモード
  goto w2xco_file
  )
 )
 

echo %DATE% %TIME% 初期準備が完了しました。 >>%logname%.log 2>>&1
echo %DATE% %TIME% 初期準備が完了しました。
echo ------------------------------------------- >>%logname%.log 2>>&1
echo -------------------------------------------




:===========================================================================================================================================

:w2xco_file

call wtb.bat START
:ファイル名
echo %~n1 >>%logname%.log 2>>&1
echo %~x1 >>%logname%.log 2>>&1
echo %~p1 >>%logname%.log 2>>&1
if "%mode01%" == "auto_scale" goto nam_autoo
if "%mode01%" == "noise_scale" goto nam_ao
if "%mode01%" == "noise" goto nam_bo
if "%mode01%" == "scale" goto nam_co

:nam_autoo
if /I "%~x1" == ".jpg" (
 goto nam_ao
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_ao
 ) else (
 goto nam_co
 )
 
:nam_ao
set mode01nam=%~n1_waifu2x-converter-cpp-%mode01%-Lv%noise_level01%-%scale_ratio01%x%~x1
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:nam_bo

set mode01nam=%~n1_waifu2x-converter-cpp-noise-Lv%noise_level01%%~x1
set mode01var=-m noise --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:nam_co

set mode01nam=%~n1_waifu2x-converter-cpp-%mode01%-%scale_ratio01%x%~x1
set mode01var=-m scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamo

:EONamo

if "%~1" == "" goto Finish_w2x


echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換を開始します... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換を開始します...

%usewaifu% --model_dir ".\models\%model01%" %mode01var% -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\%mode01nam%" %otheropco01% >>%logname%.log 2>>&1


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
 pushd %~1
 if Errorlevel 1 (
 goto w2xco_file
 ) else (
 popd
 goto restart
 )
:===========================================================================================================================================
:w2xca_file
call wtb.bat START
:ファイル名

if "%mode01%" == "auto_scale" goto nam_autoa
if "%mode01%" == "noise_scale" goto nam_aa
if "%mode01%" == "noise" goto nam_ba
if "%mode01%" == "scale" goto nam_ca

:nam_autoa
if /I "%~x1" == ".jpg" (
 goto nam_aa
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_aa
 ) else (
 goto nam_ca
 )
 
:nam_aa
set mode01nam=%~n1_waifu2x-caffe-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONama

:nam_ba

set mode01nam=%~n1_waifu2x-caffe-%mode01%-Lv%noise_level01%.%out_ext01%
set mode01var=-m noise --noise_level %noise_level01%
goto EONama

:nam_ca

set mode01nam=%~n1_waifu2x-caffe-%mode01%-%scale_ratio01%x.%out_ext01%
set mode01var=-m scale --noise_level --scale_ratio %scale_ratio01%
goto EONama

:EONama

if "%~1" == "" goto Finish_w2x


echo.
echo. >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換を開始します... >>%logname%.log 2>>&1
echo %DATE% %TIME% "%~1"の変換を開始します...

waifu2x-caffe-cui -p %process01% --model_dir ".\models\%model01%" %mode01var% -i %~1 -o "%~dp1\%outfolder%\%mode01nam%" %otheropca01% >>%logname%.log 2>>&1

set w2xcERROR=%ERRORLEVEL%

if "%w2xcERROR%" GEQ "1" (
 if "%process01%" == "gpu" (
  set usewaifu=waifu2x-converter_x64
  echo %DATE% %TIME% Nvidia GPUでの変換を試みましたが、できませんでした。converterに移しその他のハードでの変換を開始します。 >>%logname%.log 2>>&1
  echo %DATE% %TIME% Nvidia GPUでの変換を試みましたが、できませんでした。converterに移しその他のハードでの変換を開始します。
  goto w2xco_file
  ) else (
  echo Error! >>%logname%.log 2>>&1
  echo Error!
  )
 ) else (
 echo %DATE% %TIME% "%~1"の変換作業が正常に終了しました。生成画像名:%mode01nam% >>%logname%.log 2>>&1
 echo %DATE% %TIME% "%~1"の変換作業が正常に終了しました。生成画像名:%mode01nam%
  call wtb.bat STOP
 echo "%~1"変換時間 >>%logname%.log 2>>&1
 call wtb.bat PRINT >>%logname%.log 2>>&1
 echo "%~1"変換時間
 call wtb.bat PRINT
 shift
 pushd %~1
 if Errorlevel 1 (
 goto w2xca_file
 ) else (
 popd
 goto restart
 )
 )

:===========================================================================================================================================
:w2xco_folder
set 1="%foldernamevar%"
pushd %~dpn1
set hoge=*.%inexli01::= *.%
echo %hoge% 
if "%subf01%" == "true" (
 echo サブフォルダ処理モード >>%logname%.log 2>>&1
 for /R %%t in (%hoge%) do call :w2xcof1 "%%~t"
 ) else (
 for %%t in (%hoge%) do call :w2xcof1 "%~dpn1\%%~t"
 )
if not "%~1" == "" (
 shift
 goto restart
 )
goto  Finish_w2x



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
set mode01nam=%~n1_waifu2x-converter-cpp-noise_scale-Lv%noise_level01%-%scale_ratio01%x%~x1
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:nam_bf

set mode01nam=%~n1_waifu2x-converter-cpp-noise-Lv%noise_level01%%~x1
set mode01var=-m noise --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:nam_cf

set mode01nam=%~n1_waifu2x-converter-cpp-scale-%scale_ratio01%x%~x1
set mode01var=-m scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamf

:EONamf
echo.
echo. >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します... >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します...

%usewaifu% --model_dir ".\models\%model01%" !mode01var! -j %NUMBER_OF_PROCESSORS% -i "%~1" -o "%~dp1\waifued\!mode01nam!" %otheropco01% >>%logname%.log 2>>&1


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
:w2xca_folder
set 1="%foldernamevar%"
pushd %~dpn1
set hoge=*.%inexli01::= *.%
echo %hoge% 
if "%subf01%" == "true" (
 for /R %%t in (%hoge%) do call :w2xcaf1 "%%~t"
 ) else (
 for %%t in (%hoge%) do call :w2xcaf1 "%~dpn1\%%~t"
 )
if "%w2xcERROR%" GEQ "1" (
 set usewaifu=waifu2x-converter_x64
 echo !DATE! !TIME! Nvidia GPUでの変換を試みましたが、できませんでした。converterに移しその他のハードでの変換を開始します。 >>%logname%.log 2>>&1
 echo !DATE! !TIME! Nvidia GPUでの変換を試みましたが、できませんでした。converterに移しその他のハードでの変換を開始します。
 goto w2xco_folder
)
shift
if not "%~1" == "" (
 shift
 goto restart
 )
goto  Finish_w2x



:w2xcaf1
popd
set cafname=%~n1
if not "!cafname:waifu2x=hoge!" == "!cafname!" exit /b >>%logname%.log 2>>&1
mkdir %~dp1\%outfolder%

call wtb.bat START

:ファイル名

if "%mode01%" == "auto_scale" goto nam_autofa
if "%mode01%" == "noise_scale" goto nam_afa
if "%mode01%" == "noise" goto nam_bfa
if "%mode01%" == "scale" goto nam_cfa

:nam_autofa
if /I "%~x1" == ".jpg" (
 goto nam_afa
 ) else if /I "%~x1" == ".jpeg" (
 goto nam_afa
 ) else (
 goto nam_cfa
 )
 
:nam_afa
set mode01nam=%~n1_waifu2x-caffe-%mode01%-Lv%noise_level01%-%scale_ratio01%x.%out_ext01%
set mode01var=-m noise_scale --noise_level %noise_level01% --scale_ratio %scale_ratio01%
goto EONamfa

:nam_bfa

set mode01nam=%~n1_waifu2x-caffe-%mode01%-Lv%noise_level01%.%out_ext01%
set mode01var=-m noise --noise_level %noise_level01%
goto EONamfa

:nam_cfa

set mode01nam=%~n1_waifu2x-caffe-%mode01%-%scale_ratio01%x.%out_ext01%
set mode01var=-m scale --scale_ratio %scale_ratio01%
goto EONamfa

:EONamfa
echo.
echo. >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します... >>%logname%.log 2>>&1
echo !DATE! !TIME! "%~1"の変換を開始します...

waifu2x-caffe-cui -p !process01! --model_dir ".\models\%model01%" %mode01var% -i "%~1" -o "%~dp1\%outfolder%\!mode01nam!" %otheropca01% >>%logname%.log 2>>&1

set w2xcERROR=!ERRORLEVEL!

if "!w2xcERROR!" GEQ "1" (
 exit /b
 )
 echo !DATE! !TIME! "%~1"の変換作業が正常に終了しました。生成画像名:!mode01nam! >>%logname%.log 2>>&1
 echo !DATE! !TIME! "%~1"の変換作業が正常に終了しました。生成画像名:!mode01nam!
 call wtb.bat STOP
 echo "%~1"変換時間 >>%logname%.log 2>>&1
 call wtb.bat PRINT >>%logname%.log 2>>&1
 echo "%~1"変換時間
 call wtb.bat PRINT


exit /b
 
:===========================================================================================================================================

:Finish_w2x



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