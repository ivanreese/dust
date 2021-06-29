Take ["DOOM", "Grid", "DOMContentLoaded"], (DOOM, Grid)->

    elm = DOOM.create "canvas", document.body
    ctx = elm.getContext "2d"

    screen = hw:0, hh:0, w:0, h:0
    camera = x:0, y:0

    resize = ()->
      dpr = window.devicePixelRatio
      screen.w = window.innerWidth
      screen.h = window.innerHeight
      screen.hw = screen.w/2
      screen.hh = screen.h/2
      elm.width = screen.w * dpr
      elm.height = screen.h * dpr
      ctx.resetTransform()
      ctx.scale dpr, -dpr
      ctx.translate screen.hw|0, -screen.hh|0

    resize()
    window.addEventListener "resize", resize

    render = ()->
      ctx.clearRect -screen.hw, -screen.hh, screen.w, screen.h
      Grid ctx, camera, screen
      requestAnimationFrame render

    requestAnimationFrame render
