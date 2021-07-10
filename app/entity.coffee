Take ["Colors", "Vec2", "World"], (Colors, Vec2, World)->

  template =
    type: "Entity"
    pos: Vec2()
    angle: 0
    radius: 40
    color: Colors.particle
    scale: 1

  Make.async "Entity", Entity = (...props)-> # Accepts names of props (to Take templates) or plain objects
    for prop, i in props when String.type prop
      props[i] = Take(prop).template
    obj = Object.merge template, ...props
    for k of obj
      Take(k)?.create? obj
    obj


  Entity.render = (obj, dt, ctx)->
    p = World.toCamera obj.pos
    # Center
    ctx.beginPath()
    ctx.fillStyle = obj.color
    ctx.circle p.x, p.y, obj.radius * obj.scale
    ctx.fill()
    ctx.beginPath()
    # Normal
    # ctx.strokeStyle = Colors.fg
    # ctx.strokeWidth = 4
    # ctx.moveTo p.x, p.y
    # p = World.toCamera World.fromObject obj, Vec2.rotate Vec2(50 * obj.scale, 0), obj.angle
    # ctx.lineTo p.x, p.y
    # ctx.stroke()
