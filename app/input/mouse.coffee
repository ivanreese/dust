Take ["Camera", "Scene", "Vec2"], (Camera, Scene, Vec2)->

  lastPos = null
  state = "up"

  eventPos = (e)-> Vec2 e.clientX - window.innerWidth/2, window.innerHeight/2 - e.clientY

  window.addEventListener "mousedown", (e)->
    pos = lastPos = eventPos e
    deltaPos = Vec2()
    state = "down"

    worldPos = Vec2.sub pos, Camera.pos

    for obj in Scene.objects
      if Vec2.dist(worldPos, obj.pos) <= obj.radius + 2
        Scene.select obj
        return

    Scene.select null


  window.addEventListener "mousemove", (e)->
    return if state is "up"

    pos = eventPos e
    deltaPos = Vec2.sub pos, lastPos
    lastPos = pos

    if Scene.selection.length > 0
      for obj in Scene.selection
        obj.pos = Vec2.add deltaPos, obj.pos

    else if state is "down" and Vec2.len(deltaPos) >= 5
      state = "panning"

    else if state is "panning"
      Camera.move deltaPos


  window.addEventListener "mouseup", (e)->
    state = "up"
