#import "/template/constants.typ": assets, date-format

#let backcover(
  title: "",
  publisher: "",
  editor-chief: "",
  editions: (),
) = {
  set page(
    header: none,
    footer: none,
    margin: (x: 25mm, top: 25mm, bottom: 18mm),
  )
  set par(first-line-indent: (amount: 0pt, all: false))

  pagebreak(to: "even")

  text(size: 19pt)[情報科学類誌]
  // 普通に画像を調整するべき
  move(
    dy: -4pt,
    image(
      width: 100%,
      assets.wordlogo,
    ),
  )

  place(
    center + horizon,
    box(text(size: 28pt, top-edge: "baseline", title)),
  )

  let textL = it => text(size: 18pt, it)
  let textM = it => text(size: 12pt, it)

  place(
    center + bottom,
    box(
      width: 100%,
      stroke: 0.5pt + black,
      inset: (x: 20pt, y: 20pt),
      grid(
        align: left,
        columns: (auto, 1fr),
        rows: auto,
        column-gutter: 20pt,
        row-gutter: 10pt,
        textL[発行者], textL[#publisher],
        [], [],
        textL[編集長], textL[#editor-chief],
        textL[], textL[筑波大学情報学群],
        textL[], textL[情報科学類 WORD 編集部],
        textL[制作・編集], textL[（第三エリアC棟212号室）],
        [], [],

        ..editions
          .enumerate(start: 1)
          .map(((index, edition)) => (
            textM[#edition.date.display(date-format)],
            textM[初版第#{ index }刷発行 #h(1fr) (#{ edition.circulation }部)],
          ))
          .flatten(),
      ),
    ),
  )
}
