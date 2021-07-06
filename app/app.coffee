Take ["Grid", "Particles", "Ring", "Scene", "SVG"], (Grid, Particles, Ring, Scene, SVG)->

  lastTime = performance.now()

  requestAnimationFrame render = (time)->
    requestAnimationFrame render

    dt = Math.min 0.1, (time - lastTime) / 1000
    lastTime = time

    # UPDATE
    Take(obj.type).update? obj, dt for obj in Scene.objects
    Particles.update dt

    # RENDER
    Grid()
    SVG.render()
    Take(obj.type).render? obj, dt for obj in Scene.objects
    Ring.render()
    Particles.render dt

    null
