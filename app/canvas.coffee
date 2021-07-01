Take ["DOOM", "DOMContentLoaded"], (DOOM)->

  elm = DOOM.create "canvas", document.body
  ctx = elm.getContext "2d"
  size = null

  Make.async "Canvas", Canvas =
    ctx: ctx
    size: null
    clear: ()-> ctx.clearRect -size.hw, -size.hh, size.w, size.h

  resize = ()->
    w = window.innerWidth
    h = window.innerHeight
    hw = w/2
    hh = h/2
    dpr = window.devicePixelRatio
    elm.width = w * dpr
    elm.height = h * dpr
    ctx.resetTransform()
    ctx.scale dpr, -dpr
    ctx.translate hw|0, -hh|0
    Canvas.size = size = {w, h, hw, hh}

  resize()
  window.addEventListener "resize", resize
