# 詳しい使い方
## 対応環境

- OS:Windows(7~)です。
  - 動作確認はWindows 10 Homeで行っています。
  - 7だと終了時に音が鳴らないかもしれません。その場合は他のファイルを指定してください。

## 基本的な使い方

1. 画像や画像が入ったフォルダをドラッグアンドドロップします。
  - 対応するものはごっちゃに投入しても変換してやります。
2. 黒いコマンドプロンプトの画面が出てきます。
3. 変換が済むと音がなります。
4. 変換した画像は、指定したようにフォルダに投入されています。
  - フォルダ投入方法や設定方法は後述

## web版との違い

twitterでwaifu2xを検索すると、ウェブサービスで変換している方が多いようです。

このセットは、おもにwaifu2x-converter-cppまたはwaifu2x-caffeというソフトのWindows向けのバイナリ(exeファイル)を使い、すべての画像処理をパソコンで行います。

もしかしたら、あなたのパソコンはwaifu2xを実行できないほど貧弱かもしれません。

しかし、NVIDIAやAMD製のGPUを付けているパソコンだったら、web版よりはやく実行できます。

貧弱なパソコンでも、すっきり！デフラグのその他のアプリケーションを実行するモードでバッチファイルを実行すれば多少高速化できるかもしれません。ただ、その方法はここには示しません。なぜなら、それくらい調べるられるかすぐ理解できるようなユーザーにでないとお勧めできない方法だからです。

- インターネットに画像を送信しないため、機密性があります。
  - tamainaのgithubのページから配布されたこのセットのプログラムは、実行中にインターネット上に処理画像を流出しないことを保証します。
- フォルダごと処理できます。
- 設定方法が若干違います。
  - GUIでなく、メモ帳で編集します。
  - メモ帳でバッチファイルを直接弄らなければならないのが唯一の欠点です。
  
## 設定方法

1. メモ帳で編集したいバッチファイル(拡張子.bat)を開きます。
  - 必要があれば複製したファイルを編集します。
2. 設定項目の詳細はバッチファイルに記していますが、若干見辛いのでこのファイルにも軽く示しておきます。

## 設定項目

web版と設定項目は違います。

converter-cppやcaffeに慣れている方であれば抵抗なく編集できるでしょう。

先頭のlxxxは行番号です。

### l 14 : 動作モード[-m --mode]

- ノイズ除去をするか、拡大をするか、両方するかをここで決めます。
- 無効にした機能の設定は無視されます。

### l 25 : モデル選択[--model_dir]

- イラスト画像向けか写真画像向けかを選べます。
  - waifu2xでは、拡大やノイズ除去をする際の基になる「モデル」があります。モデルに基づいて、どのようにきれいに拡大をするかを考えているのです。

### l 30～ 拡大率

####自動倍率計算

バッチファイル独自の機能として、自動的に倍率を計算します。

自動倍率計算は、処理が終わったときの幅・高さ(px)を指定し、それに合わせて拡大率を計算するものです。

waifu2xでの拡大率は2の累乗に設定し、ImageMagickというソフトを使って目標の幅高さに縮小しています。

なので、ImageMagickの導入が必要なのです。

自動倍率計算を有効にすると、拡大が必要ない画像はただ縮小されます。

自動倍率計算が無効の場合は、拡大率を手動で設定します。2倍や1.6倍以外の指定も可能です。

### l 82 : ノイズ除去レベル[--noise_level]

- 1(弱),2(強),super(さいきょう)が選べます。

superは、昔のモデルデータのノイズ除去/拡大能力が強すぎたことを利用しています。

しかし、二次画像を拡大するならこれくらいがちょうどいいかもしれません。

### l 93 : 変換する拡張子[-l --input_extention_list]

- 入力されたファイルのなかで変換したい拡張子を指定します。

### l102 : 出力拡張子[-e --output_extention]

- 廃止しました。おのおののファイルはすべてpngで保存されます。
  - 将来、出力したpngをImageMagickで指定した拡張子に変換できる機能を追加する予定です。

### l113 : フォルダを処理するときサブフォルダも処理する[bat独自]

- こういうのを難しい用語で「再帰的に処理する」といいます。

### l122 : 使用するwaifu2x[bat独自]

- converter-cppかcaffeかが選べますが、個人的にconverter-cppがお勧めです。
  - 理由は、cpuではconverter-cppがとても有利に働くからです。
- どちらを選んでも、処理後の画質が変わることはありません。

### l133～ 出力設定

問題の(？)出力フォルダ関連の設定です。

#### ふたつの出力方法

1. ドラッグアンドドロップしたファイルが入っているフォルダごとに、フォルダを作ってその中に処理後の画像を放り込む
2. 最初に入力されたファイルが入っているフォルダの中に、フォルダを作って、その中にすべての処理後の画像を放り込む

また、オプションとして

- フォルダを作らない
- 2の方法で作ったフォルダを圧縮して出力する(←multiの機能を真似ました)

という方法もあります。それぞれの設定方法はバッチファイルをご確認ください。

### l179 : 処理終了時に音を鳴らす[bat独自]

- デフォルトでは、windows10標準のアラーム音を指定しています。
- 追加情報:SoXのオプションや引数を入力できます。

### l190 : TwitterMode[bat独自]

- 左上1ドットを少しだけ透明にして、twitterに載せたときjpegになるのを防ぎます。
- 3MBを上回った場合、pngquantで軽量化します。
  - すこし減色されますが、jpegのようなノイズが出てくるわけではありません。

### l208 : alpha情報をバッチファイルで処理する

- 相性がいい画像と悪い画像があるため、選択できるようにしました。
- しかし、普通の画像を変換するには有効にしてあればきれいに変換することができます。

### l222 : その他のオプション

- 各種アプリケーションに追加でオプションが指定できます。
  - caffeの分割設定を設定したりすることが可能です。
