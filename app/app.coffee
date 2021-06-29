Take ["Canvas", "Grid"], (Canvas, Grid)->

    camera = x:0, y:0
    mouse = x:0, y:0

    instances = []
    particles = []

    render = ()->
      {ctx, size} = Canvas

      ctx.clearRect -size.hw, -size.hh, size.w, size.h
      Grid ctx, size, camera

      strength = 100
      maxVel = 5

      wind =
        x: mouse.x - camera.x
        y: mouse.y - camera.y

      angle = Math.atan2 wind.y, wind.x

      for p in particles
        d = dist wind.x, wind.y, p.pos.x, p.pos.y
        p.vel.x = Math.cos(angle) * Math.min maxVel, strength / (d*d)
        p.vel.y = Math.sin(angle) * Math.min maxVel, strength / (d*d)

        p.pos.x += p.vel.x
        p.pos.y += p.vel.y

        ctx.beginPath()
        ctx.fillStyle = "hsl(200, 60%, 80%)"
        ctx.arc p.pos.x-0.5+camera.x, p.pos.y-0.5+camera.y, 1, 0, Math.TAU
        ctx.fill()

      for i in [-2..1] by 0.5
        r = 1 / 5 ** i
        alpha = Math.lerp i, -2, 1, 0.5, 1

        ctx.beginPath()
        ctx.strokeStyle = "hsla(20, 80%, 70%, #{alpha})"
        ctx.arc wind.x+camera.x, wind.y+camera.y, r, 0, Math.TAU
        ctx.stroke()

      requestAnimationFrame render

    for x in [-600..600] by 10
      for y in [-200..200] by 10
        particles.push
          pos: {x, y}
          vel: x:1, y:0

    requestAnimationFrame render

    dist = (x1, y1, x2, y2)-> Math.sqrt (x2-x1)**2 + (y2-y1)**2


    # Camera movement

    dragging = null

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
