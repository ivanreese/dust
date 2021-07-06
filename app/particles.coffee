Take ["Camera", "Canvas", "Vec2"], (Camera, Canvas, Vec2)->

  ctx = Canvas style: "z-index: 1"

  Make.async "Particles", Particles =
    list: []

  Particles.update = (dt)->
    for p, i in Particles.list by -1
      vel = Vec2.fromPolar p.angle, p.speed
      p.pos = Vec2.add p.pos, Vec2.mulS vel, dt
      p.age += dt
      p.rFade = p.radius * Math.min 1, Math.min p.maxAge - p.age, p.age
      Particles.list.splice i, 1 if p.age > p.maxAge

  Particles.render = (dt)->
    ctx.clear()
    for p, i in Particles.list by -1
      screenPos = Vec2.add p.pos, Camera.pos
      ctx.beginPath()
      ctx.fillStyle = p.color
      ctx.circle screenPos.x, screenPos.y, p.rFade
      ctx.fill()
