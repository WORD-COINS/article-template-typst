#import "/template/utils.typ": body-setting, page-setting
#import "@preview/cjk-unbreak:0.2.3": remove-cjk-break-space

#let has-initialized-state = state("has-initialized-state", false)

#let initialize(body) = {
  show: page-setting

  context if not has-initialized-state.get() {
    show: remove-cjk-break-space
    show: body-setting

    body
  } else {
    body
  }

  has-initialized-state.update(true)
}
