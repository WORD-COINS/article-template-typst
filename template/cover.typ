#import "/template/constants.typ": assets

#let cover() = {
  set page(
    header: none,
    footer: none,
    background: image(assets.cover),
  )

  pagebreak()
}
