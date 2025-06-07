# WORDの記事の雛形 Typst版

[WORD-COINS/article-template](https://github.com/WORD-COINS/article-template) をもとに Typst で実装された記事のテンプレートです。

## 必要なもの

- [Git](https://git-scm.com/)
- [Typst](https://typst.app/)
- [GNU Make](https://www.gnu.org/software/make/)

## オンラインエディタ

オンラインエディタで記事全体を見たり、フォークして編集することができます。

- [全体版](https://typst.app/project/rqwZqick30FpZ9Y7ulL0LD)
- [単一記事版](https://typst.app/project/rHrX8BCoMolpFryTcFyUeW)

<sup>オンラインエディタでは最新の変更が取り込まれていない場合があります。オンラインエディタ上の `version.txt` を確認してください。</sup>

## 編集の仕方

### 0. ビルドに必要な環境を整える

リポジトリのルートで

```
make setup
```

を実行すると、不足している記事のコンパイルに必要なフォントがダウンロードされます。
**Bash 4系以上が必要です**（特に macOS にプリインストールの bash はこの条件を満たさない可能性があります）。

### 1. ブランチを切る

記事を入れるディレクトリ名に合わせて Git のブランチを切ります。
記事のディレクトリを `my_article` とした場合、次のようにコマンドを打ちます。

```
git switch -c articles/my_article
```

注意する点として、article **s** である点です。
article だと CI が走らないので気を付けてください。

### 2. 記事のディレクトリを作る

`articles` ディレクトリの `hinagata` （Markdown で書きたい場合は `hinagata-markdown`）をコピーして、任意の名前をつけます。
このときの名前はなんでも構いませんが日本語を使うとややこしくなるのでやめましょう。
このときのディレクトリ名をここでは `my_article` としたとして話をすすめます。

### 3. 記事を目次に加える

次のコマンドを実行してリポジトリ直下にある `main.typ` に対して、末尾に作成した記事を追加します。

```
echo '\n#include "articles/my_article/main.typ"' >> main.typ
```

と実行するなどしてください。

### 4. 記事を編集する

手順 (2) で作成したディレクトリの中にあるファイル `main.typ`（Markdown テンプレートを使用した場合は `main.md`）を編集することで、記事をつくれます。

## コンパイル

### 全体のコンパイル

リポジトリのルートディレクトリで `make compile` しましょう。

### 各記事のコンパイル

目次と裏表紙が必要ない場合は `articles/` 以下の記事ディレクトリに `cd` して `make compile` しましょう。

### ホットリロード

`make compile` の代わりに `make watch` を実行することで、記事の内容が変更されるたびに PDF がコンパイルされます。
これと、自動更新が可能な PDF ビュアーなどを組み合わせることにより、記事のホットリロードを実現することが可能です。

## 質問・その他の情報

このテンプレートを制作した [@Ryoga-exe](https://github.com/Ryoga-exe) に投げると早い。

## ライセンス

TBD
