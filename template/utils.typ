#let fonts = (
  header: ("TeX Gyre Termes", "Noto Serif CJK JP"),
  heading: ("TeX Gyre Termes", "Noto Sans CJK JP"),
  body: ("TeX Gyre Termes", "Noto Serif CJK JP"),
  raw: ("Source Code Pro", "Noto Sans CJK JP"),
  page-number: "EB Garamond",
)

#let jp-pattern = "[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}]"

#let pageno = (page-numbering, display-page, actucal-page) => {
  if (page-numbering == none) {
    none
  } else {
    let isOdd = calc.odd(actucal-page)
    place(
      if isOdd { right } else { left },
      dx: 13mm * if (isOdd) { 1 } else { -1 },
      text(
        10pt,
        font: fonts.page-number,
        number-type: "old-style",
        numbering(page-numbering, display-page),
      ),
    )
  }
}

#let page-setting(rest) = {
  set page(
    paper: "jis-b5",
    margin: (x: 25mm, top: 26mm, bottom: 15mm),
    binding: auto,
    numbering: "1",
    header: context {
      set par(first-line-indent: (amount: 0pt, all: false))
      set text(font: fonts.header, weight: "medium", lang: "ja")

      let current-chapter = query(heading.where(level: 1))
        .filter(it => it.location().page() <= here().page())
        .at(-1, default: none)

      if current-chapter != none {
        block(
          width: 100%,
          stroke: (
            bottom: (thickness: 0.5pt),
          ),
          align(
            if calc.even(here().page()) { left } else { right },
            box(
              inset: (y: 30%),
              text(size: 9pt, current-chapter.body),
            ),
          ),
        )
      }
    },
    footer: context {
      pageno(here().page-numbering(), counter(page).get().at(0), here().page())
    },
    header-ascent: 22%,
    footer-descent: 20%,
  )

  rest
}

#let body-setting(rest) = {
  set text(
    font: fonts.body,
    lang: "ja",
    size: 9pt,
  )

  set par(
    leading: 1.1em,
    spacing: 1.1em,
    justify: true,
    linebreaks: auto,
    first-line-indent: (
      amount: 1em,
      all: true,
    ),
  )
  set heading(
    numbering: (_, ..args) => {
      let nums = args.pos()
      if (nums.len() > 3) {
        none
      } else {
        nums.map(str).join(".")
        h(0.55em)
      }
    },
  )

  show heading: set text(font: fonts.heading, weight: "bold", lang: "ja")
  show heading: it => {
    show regex(jp-pattern): set text(
      size: 0.9em,
      weight: "medium",
    )
    it
  }
  show heading.where(level: 1): it => {
    // pagebreak(weak: true)
    pad(
      top: 8pt,
      bottom: 14pt,
      align(
        center,
        text(size: 20pt, it),
      ),
    )
  }

  show heading.where(level: 2): it => pad(
    top: 6pt,
    bottom: 4pt,
    text(size: 15pt, it),
  )
  show heading.where(level: 3): it => pad(
    top: 6pt,
    bottom: 4pt,
    text(size: 13pt, it),
  )
  show heading.where(level: 4): it => pad(
    top: 2pt,
    bottom: 2pt,
    text(size: 12pt, it),
  )
  show heading.where(level: 4): set heading(numbering: none)
  show heading.where(level: 5): set heading(numbering: none)
  show heading.where(level: 6): set heading(numbering: none)
  show heading.where(level: 7): set heading(numbering: none)
  show heading.where(level: 8): set heading(numbering: none)

  show strong: set text(
    font: fonts.heading,
    weight: 450,
  )
  set list(indent: 2em, spacing: 1.1em)
  set enum(indent: 2em, spacing: 1.1em)
  set terms(indent: 2em, spacing: 1.1em)
  show list: set block(spacing: 2em)
  show enum: set block(spacing: 2em)
  show terms: set block(spacing: 2em)

  show raw: set text(font: fonts.raw)
  set raw(
    // コメントだけ色が薄いカラースキーム
    theme: "assets/quiet.tmTheme",
  )

  show quote: set pad(0em)
  show quote.where(): set block(below: 0mm, above: 0mm)
  show quote.where(): it => {
    block(
      width: 100%,
      stroke: (left: (paint: luma(45%), thickness: 0.3mm)),
      inset: (left: 4mm, y: 2mm, right: 0mm),
      outset: 0pt,
      above: 1.5em,
      below: 1.5em,
      breakable: false,
      text(fill: luma(30%), it),
    )
  }

  set footnote(numbering: sym.dagger + "1")
  show footnote: it => {
    set text(size: 1em)
    it
  }
  show footnote.entry: it => {
    set text(size: 0.85em)

    grid(
      columns: (auto, 1fr),
      gutter: 0.75em,
      numbering(sym.dagger + "1", ..counter(footnote).at(it.note.location())), it.note.body,
    )
  }

  show figure: it => pad(y: 2em, it)
  show figure.caption: it => pad(top: 1.0em, text(0.95em, it))
  show math.equation.where(block: true): set block(spacing: 1.5em)
  set math.cases(gap: 0.8em)
  set math.mat(gap: 0.8em)

  rest
}
