# This our main loop
Take ["Camera", "Canvas", "Grid", "Scene", "SVG", "Vec2"], (Camera, Canvas, Grid, Scene, SVG, Vec2)->

  lastTime = performance.now()

  requestAnimationFrame render = (time)->
    requestAnimationFrame render

    dt = Math.min 0.1, (time - lastTime) / 1000
    lastTime = time

    for obj in Scene.objects
      Take(obj.type).update? obj, dt
      DOOM obj.elm, transform: "translate(#{obj.pos.x},#{obj.pos.y}) rotate(#{obj.angle*360/Math.TAU})"

    for p, i in Scene.particles by -1
      vel = Vec2.fromPolar p.angle, p.speed
      p.pos = Vec2.add p.pos, Vec2.mulS vel, dt
      p.age += dt
      Scene.particles.splice i, 1 if p.age > p.maxAge

    Canvas.clear()
    Grid()
    SVG.render()
    for obj in Scene.objects
      Take(obj.type).render? obj, dt

    for p,i in Scene.particles
      screenPos = Vec2.add p.pos, Camera.pos
      Canvas.ctx.beginPath()
      Canvas.ctx.fillStyle = p.color
      Canvas.circle screenPos.x, screenPos.y, p.radius
      Canvas.ctx.fill()

    null

# This sets up test data
Take ["Emitter", "Push", "Scene"], (Emitter, Push, Scene)->
  Scene.objects.push Emitter()
  Scene.objects.push Push angle: Math.PI, pos: x: 192
  Scene.objects.push Push angle: -Math.PI/2, pos: y: 192
  Scene.objects.push Push angle: 0, pos: x: -192
  Scene.objects.push Push angle: Math.PI/2, pos: y: -192
