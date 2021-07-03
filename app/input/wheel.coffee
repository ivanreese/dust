Take ["Camera", "Vec2"], (Camera, Vec2)->

  wheel = (e)->
    e.preventDefault()
    Camera.move Vec2 -e.deltaX, e.deltaY

  window.addEventListener "wheel", wheel, passive: false
