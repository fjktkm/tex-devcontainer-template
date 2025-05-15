# LaTeX 執筆用開発コンテナ

LaTeX の執筆を快適に行うための開発コンテナのテンプレートです．
なるべくシンプルで汎用的に使えることを心がけています．

## ✅ Requirements

動作に必要なものは次のとおりです：

- [Docker Desktop](https://www.docker.com/)
- [Visual Studio Code（VSCode）](https://code.visualstudio.com/)
- [Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

### Docker Desktop

[公式ドキュメント](https://docs.docker.com/get-started/) の手順に従って Docker Desktop をインストールしてください．

> [!TIP]
> Windows の場合は [Microsoft Store](https://apps.microsoft.com/detail/XP8CBJ40XLBWKX?hl=ja&gl=JP&ocid=pdpshare) からのインストールがおすすめです．

### VSCode

[公式ドキュメント](https://code.visualstudio.com/docs/setup/setup-overview) の手順に従って VSCode をインストールしてください．

> [!TIP]
> ちょうど最近 Microsoft Store 版がリリースされました（2025 年 5 月時点）．
> Windows の場合これからは [Microsoft Store 版](https://apps.microsoft.com/detail/XP9KHM4BK9FZ7Q?hl=ja&gl=JP&ocid=pdpshare) を使うのが良いでしょう．

### Remote Development Extension Pack

VSCode に [Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) をインストールしてください．
VSCode の [公式ドキュメント](https://code.visualstudio.com/docs/getstarted/extensions) を参考にインストールしてください．

> [!NOTE]
> Remote Development Extension Pack は，デフォルトでインストールされている場合があります．

## 🚀 Usage

### 1. リポジトリのクローン

お好きな方法で構いませんが，このリポジトリをローカルにクローンしてください．

> [!TIP]
> 個人的には [GitHub Desktop](https://desktop.github.com/) を使う方法がおすすめです．

### 2. VSCode でリポジトリを開く

VSCode を起動し，クローンしたリポジトリのフォルダを開いてください．

> [!TIP]
> GitHub Desktop でクローンした場合は，クローン完了時に表示される「Open in Visual Studio Code」ボタンをクリックするのが楽なのでおすすめです．

### 3. 開発コンテナで開く

リポジトリを開くと VSCode が `.devcontainer` フォルダを検出し，開発コンテナで開くかどうかを尋ねるポップアップが表示されます．
ポップアップが表示されたら，「コンテナーで再度開く」をクリックしてください．
開発コンテナの初回起動時には，コンテナイメージのダウンロードが行われるため，少し時間がかかります．

> [!TIP]
> ポップアップが表示されない場合は，ウィンドウの左下にある「><」アイコンをクリックし，「コンテナーで再度開く」を選択してください．
> Ctrl + Shift + P を押してコマンドパレットを開き，「開発コンテナ: コンテナーで再度開く」を選択することでも開くことができます．

### 4. LaTeX ファイルを編集する

開発コンテナが起動したら，すぐに LaTeX の執筆を始めることができます．
サンプルとして `LuaLaTeX`，`pLaTeX`，`upLaTeX` のプロジェクトを用意してあります．
ファイルを編集し保存すると自動でコンパイルが開始され，`dist/` フォルダに PDF が生成されます．

`dist/` フォルダに生成された PDF をクリックすると，PDF が表示されます．
ライブプレビューが可能なので，TeX ファイルと PDF を左右に並べて作業すると Overleaf や Cloud LaTeX のように快適に執筆できます．

> [!TIP]
> TeX ファイルのウィンドウの右上に表示される「LaTeX PDF ファイルを表示」ボタンをクリックすることでも PDF が表示されます．
> ほかにも Ctrl + Alt + V を押すという方法もあります．

## ⚙️ Settings

### コンテナイメージ

このリポジトリでは TeXLive 公式が配布している `texlive/texlive:latest` イメージの使用を強く推奨します．

> [!CAUTION]
> Qiita や Zenn などでおすすめされている怪しいイメージは使用してはいけません．

### Git の改行コードの問題を解決するための設定

Git の改行コードの問題を解決するために，次のような `.gitattributes` ファイルを追加しています．

```gitattributes
* text=auto eol=lf
*.{cmd,[cC][mM][dD]} text eol=crlf
*.{bat,[bB][aA][tT]} text eol=crlf
```

Git の改行コードの問題を解決する方法はいろいろあるのですが，ユーザー依存ではなくワークスペース側で解決するほうが望ましいため，`.gitattributes` ファイルによる方法を採用しています．
詳しくは [VSCode の公式ドキュメント](https://code.visualstudio.com/docs/devcontainers/tips-and-tricks) を参照してください．

> [!NOTE]
> このリポジトリでは BAT ファイルなどは使用していないので実のところ 1 行目だけで問題ないです．
> しかし，あえてテンプレを変更する必要もないのでそのままにしています．

### 中間生成物をローカルにバインドしない設定

LaTeX のコンパイル時に生成される中間生成物は，ある種のキャッシュでありローカル環境に保存する必要はありません．
コンパイル結果が雑多であると管理が煩雑になりますし，OneDrive などのクラウドストレージを使用している場合には無駄な同期が発生してしまいます．
このような理由から，このリポジトリでは中間生成物をローカルにバインドしない設定をしています．

まず `.vscode/settings.json` で次のように `LaTeX Workshop` 拡張機能の設定を変更しています：

```json
    "latex-workshop.latex.recipe.default": "latexmk (latexmkrc)"
```

この設定により，コンパイル時に同じディレクトリにある `.latexmkrc` ファイルが読み込まれるようになります．
この `.latexmkrc` ファイルに次のような設定を追加することで，中間生成物と最終生成物の保存先を変更しています：

```perl
$out_dir = '../dist';
$aux_dir = '../build';
```

さらに，`.devcontainer/devcontainer.json` で次のように設定しています：

```json
    "mounts": [
        {
            "target": "${containerWorkspaceFolder}/build",
            "type": "volume"
        }
    ],
```

この設定により，`build` フォルダはローカルにバインドされず別のボリュームに保存されるようにすることができます．

> [!TIP]
> このテクニックは一般に Volume Trick と呼ばれます．
> ほかにも Python の `venv` や Node.js の `node_modules` など，ローカルにバインドする必要のないライブラリを保存するためによく使われます．

また，`.vscode/settings.json` で次のように設定しています：

```json
    "latex-workshop.latex.outDir": "../dist",
```

この設定により，最終生成物の保存先の変更を `LaTeX Workshop` 拡張機能に伝えています．
もしこの設定をしないと，ライブプレビューなど一部の機能が上手く動作しません．

### `latexmk` の設定

`LaTeX Workshop` 拡張機能には `.latexmkrc` なしでもコンパイルできるレシピが用意されていますが，このリポジトリでは `.latexmkrc` を挟む方法を採用しています．
これは次のような理由によるものです：

- 中間生成物の保存先を変更するため
- 文献リストの管理でカスタマイズが必要になる場合が多いため
- `.latexmkrc` があれば VSCode 以外のエディタでも同じ設定でコンパイルできるようにするため

たとえば LuaLaTeX の場合は次のような設定をしています：

```perl
$out_dir = '../dist';
$aux_dir = '../build';

$pdf_mode = 4;

$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode %O %S';
```

詳細は ChatGPT に譲ります．

> [!WARNING]
> `-interaction=nonstopmode` については `LaTeX Workshop` 拡張機能の都合によるものです．
> カスタマイズする際は引っ掛かりやすい点なので注意してください．

### LaTeX エンジン

このリポジトリでは，次の LaTeX エンジンのサンプルを用意しています：

- LuaLaTeX
- pLaTeX
- upLaTeX

大学のレポートなどで利用する際には LuaLaTeX を使用することを強く推奨します．
pLaTeX や upLaTeX は学会のスタイルファイルを使用する場合など，どうしても必要な場合にのみ使用してください．

## 文書クラス

ドキュメントクラスは `jlreq` の使用を強く推奨します．
詳細は [jlreq 公式ドキュメント](https://tug.org/docs/latex/jlreq/jlreq-ja.html) [LaTeX美文書作成入門](https://www.latex-project.org/help/documentation/) を参照してください．

> [!TIP]
> LaTeX の学習リソースについては [Learn LaTeX（日本語版）](https://www.learnlatex.org/ja/) もおすすめです．
