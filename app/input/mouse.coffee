Take ["Camera", "Grid", "Scene", "Vec2"], (Camera, Grid, Scene, Vec2)->

  down = false
  dragging = false
  downPos = null
  lastPos = null
  manipObj = null

  eventPos = (e)-> Vec2 e.clientX - window.innerWidth/2, window.innerHeight/2 - e.clientY


  window.addEventListener "mousedown", (e)->
    down = true
    pos = lastPos = downPos = eventPos e
    worldPos = Vec2.sub pos, Camera.pos

    if Scene.selection.length > 0
      for obj in Scene.selection
        if Vec2.dist(worldPos, obj.pos) <= 128 + 8 + 2
          manipObj = obj
          return

    for obj in Scene.objects
      if Vec2.dist(worldPos, obj.pos) <= obj.radius + 2
        Scene.select obj
        return

    Scene.select null


  window.addEventListener "mousemove", (e)->
    return unless down

    pos = eventPos e
    deltaPos = Vec2.sub pos, lastPos
    worldPos = Vec2.sub pos, Camera.pos
    worldPos = Vec2.map Grid.snap, worldPos if e.altKey
    lastPos = pos

    if not dragging and Vec2.dist(downPos, pos) >= 5
      dragging = true

    if dragging
      if manipObj?
        dx = worldPos.x - manipObj.pos.x
        dy = worldPos.y - manipObj.pos.y
        manipObj.angle = Math.atan2 -dx, dy

      else if Scene.selection.length > 0
        for obj in Scene.selection
          obj.pos = worldPos
      else
        Camera.move deltaPos


  window.addEventListener "mouseup", (e)->
    down = false
    dragging = false
    downPos = null
    lastPos = null
    manipObj = null
