Take ["DOOM", "DOMContentLoaded"], (DOOM)->

  Make.async "Canvas", Canvas = (opts = {})->
    canvas = DOOM.create "canvas", document.body, opts
    ctx = canvas.getContext "2d"
    size = resize canvas, ctx
    window.addEventListener "resize", ()-> size = resize canvas, ctx
    # Just a harmless bit o' monkey patching
    ctx.circle = (x, y, r)-> ctx.arc x-0.5, y-0.5, r, 0, Math.TAU
    ctx.sharpRect = (x, y, w, h)-> ctx.rect x-0.5, y-0.5, w, h
    ctx.clear = ()-> ctx.clearRect -size.dw/2|0, -size.dh/2|0, size.dw, size.dh
    ctx

  resize = (canvas, ctx)->
    w = window.innerWidth # css width
    h = window.innerHeight
    dpr = window.devicePixelRatio
    dw = canvas.width = w * dpr # [d]pi width
    dh = canvas.height = h * dpr
    ctx.resetTransform()
    ctx.scale dpr, dpr
    ctx.translate w/2|0, h/2|0 # the |0 keeps things aligned to pixel grid
    {dw, dh}
