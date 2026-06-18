#import "/template/init.typ": initialize
#import "/template/codeblock.typ": init-codeblock

#let author-label(name, authormark) = {
  if authormark == none {
    name
  } else {
    [#authormark#name]
  }
}

#let author-block(name, authormark) = [
  #metadata(name) <author>
  #align(
    right,
    pad(
      top: 1.0em,
      bottom: 1.75em,
      text(size: 10.5pt)[
        #author-label(name, authormark)
      ],
    ),
  )
]

#let reset-article-counters() = {
  counter(footnote).update(0)
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: raw)).update(0)
}

#let article(
  title: "",
  author: "",
  author-mark: [文#h(1em)編集部#h(1em)],
  body,
) = {
  show: initialize

  show: init-codeblock

  pagebreak(weak: true)

  heading(level: 1, title)
  author-block(author, author-mark)

  set heading(offset: 1)

  reset-article-counters()

  body
}
