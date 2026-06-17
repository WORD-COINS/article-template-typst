#import "/template/article.typ": article
#import "@preview/cmarker:0.1.8"
#import "@preview/mitex:0.2.7": mitex

#show: article.with(
  title: "記事を執筆しよう",
  author: "情報 太郎",
)

#cmarker.render(
  read("main.md"),
  math: mitex,
  scope: (
    image: (path, alt: none, ..args) => figure(
      image(path, alt: alt, ..args),
      caption: alt,
    ),
  ),
  html: (
    pagebreak: ("void", _ => pagebreak()),
    h: (
      "void",
      attrs => {
        h(int(attrs.value) * 1pt)
      },
    ),
    v: ("void", attrs => v(int(attrs.value) * 1pt)),
    img: (
      "void",
      attrs => figure(
        image(
          attrs.src,
          width: eval(attrs.at("width", default: "auto")),
          height: eval(attrs.at("height", default: "auto")),
        ),
        caption: attrs.alt,
      ),
    ),
  ),
)
