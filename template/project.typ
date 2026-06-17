#import "/template/init.typ": initialize
#import "/template/toc.typ": toc
#import "/template/cover.typ": cover
#import "/template/backcover.typ": backcover

#let project(
  title: "",
  author: "筑波大学情報学群 情報科学類 WORD編集部",
  publisher: "情報科学類長",
  editor-chief: "情報太郎",
  editions: ((date: datetime.today(), circulation: 128),),
  keywords: (),
  body,
) = {
  set document(
    title: title,
    author: author,
    date: editions.last().date,
    keywords: keywords,
  )
  show: initialize

  cover()
  toc()

  counter(page).update(1)
  body

  backcover(
    title: title,
    publisher: publisher,
    editor-chief: editor-chief,
    editions: editions,
  )
}
