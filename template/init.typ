#import "/template/utils.typ": body-setting, page-setting
#import "@preview/cjk-unbreak:0.2.3": remove-cjk-break-space

#let initialize-page(body) = {
  show: page-setting

  body
}

#let initialize-body(body) = {
  show: remove-cjk-break-space
  show: body-setting

  body
}

#let initialize(body) = {
  show: initialize-page
  show: initialize-body

  body
}
