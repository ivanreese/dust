Take ["Canvas", "Vec2"], (Canvas, Vec2)->

  camera = Vec2()
  mouse = Vec2()
  dragging = null

  Make.async "Camera", Camera =
    pos: camera

  window.addEventListener "mousedown", (e)->
    dragging = {clientX, clientY} = e

  window.addEventListener "mousemove", (e)->
    mouse.x = e.clientX - Canvas.size.hw
    mouse.y = Canvas.size.hh - e.clientY
    return unless dragging
    dx = e.clientX - dragging.clientX
    dy = e.clientY - dragging.clientY
    dragging = {clientX, clientY} = e
    camera.x += dx
    camera.y -= dy

  window.addEventListener "mouseup", (e)->
    dragging = null

  wheel = (e)->
    e.preventDefault()
    camera.x -= e.deltaX
    camera.y += e.deltaY

  window.addEventListener "wheel", wheel, passive: false
