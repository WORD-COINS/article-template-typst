#import "/template/article.typ": article

#let ovalbox = body => [
  #h(0.2em)
  #box(stroke: 0.5pt + black, outset: 0.35em, radius: 0.3em, body)
  #h(0.2em)
]

#show: article.with(
  title: "記事を執筆しよう",
  author: "情報 太郎",
)

= 環境を準備する

WORDの記事をコンパイルするにあたって、Typstが必要です。

- Git #footnote[https://git-scm.com/]
- Typst #footnote[https://typst.app/]
- GNU Make #footnote[https://www.gnu.org/software/make/]

記事のリポジトリをGitコマンドなどにより、クローンします。
その後、記事のGitリポジトリのルートで以下のコマンドを実行します。

```
$ make setup
```

これでコンパイルに必要なフォントなどがダウンロードされます。
必要なフォントが入っているかを確認したい場合は、`make check`で確認できます。

= コンパイルする <compile>

記事全体をコンパイルする場合は、記事のGitリポジトリのルートで次のコマンドを実行します。

```
$ make compile
```

#ovalbox[main.pdf]が作成されれば成功です。

= 記事を追加する

まず、#ovalbox[./articles/hinagata]というディレクトリをコピーして任意の名前で
#ovalbox[articles]ディレクトリへ置きます。
そして、Gitのリポジトリルートにある#ovalbox[main.typ]を開きます。

末尾に次のような行を追加します。

```typc
#include "articles/hinagata/main.typ"
```

そして、#ref(<compile>)に従って`make compile`を実行し、記事が適切にコンパイルされることを確認します。

= Gitサーバにpushする

WORDではかつて伝統あるGitoliteにより管理されていましたが、
ディスク故障によってGitのデータを失ってからBitbucketへ、そしてGitHubへと移行されました。

まず、WORDのGitHubのOrganizationである#link("https://github.com/WORD-COINS")へ参加していない場合は、
GitHubのアカウントを取得した後、編集長や管理者の誰かへ連絡してメンバーに加えてもらいましょう。

GitHubにプッシュする場合は、自分の編集を行った適当なブランチを次のコマンドでプッシュします。

```
$ git push origin articles/my_article
```

= トラブルシューティング

== 「文 編集部」の変更・削除

編集部以外のメンバーが執筆する場合「文 編集部」は必要ありません。
これは、記事の`main.typ`の`#show: article.with`の箇所を以下のように変更すれば消すことができます。

```
#show: article.with(
  title: "記事を執筆しよう",
  author: "情報 太郎",
  author-mark: none
)
```

また、以下のように変更を加えることにより、「文 編集部」の文言を変更することもできます。

```
#show: article.with(
  title: "記事を執筆しよう",
  author: "情報 太郎",
  author-mark: [文 博士号環境保全委員会]
)
```

// TODO:
