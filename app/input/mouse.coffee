Take ["Camera", "Ring", "Scene", "Vec2", "World"], (Camera, Ring, Scene, Vec2, World)->

  down = false
  dragging = false
  manipulating = null
  downPos = null
  lastPos = null

  eventPos = (e)-> Vec2


  window.addEventListener "mousedown", (e)->
    down = true
    lastPos = downPos = Vec2.fromMouse e
    worldPos = World.fromScreen downPos

    # If we clicked inside the Ring, don't change the selection
    clickedInRing = Scene.selected? and Vec2.dist(worldPos, Scene.selected.pos) < 64 + 2

    unless clickedInRing
      # See if this click selects any objects
      for id, obj of Scene.objects
        if Vec2.dist(worldPos, obj.pos) <= obj.radius + 2
          Scene.select obj
          Ring.select obj
          break

    # If we have an object selected, see if Ring wants to consume this click.
    if Scene.selected?

      manipulating = Ring.getControlAt World.toObject Scene.selected, worldPos

      # A control in the Ring consumed the click.
      if manipulating
        manipulating.start? Scene.selected, worldPos
        return

      # The ring didn't consume the click, but if we still clicked in the ring, don't deselect.
      return if clickedInRing

      # If we clicked outside the ring, we should deselect the object.
      Scene.select null
      Ring.deselect()


  window.addEventListener "mousemove", (e)->
    return unless down

    pos = Vec2.fromMouse e
    deltaPos = Vec2.sub pos, lastPos
    worldPos = World.fromScreen pos
    lastPos = pos

    if not dragging and Vec2.dist(downPos, pos) >= 5
      dragging = true

    if dragging
      if manipulating
        manipulating.change? Scene.selected, worldPos, deltaPos
      else
        Camera.move Vec2.invertY deltaPos


  window.addEventListener "mouseup", (e)->
    manipulating?.stop?()
    manipulating = null
    down = false
    dragging = false
    downPos = null
    lastPos = null
