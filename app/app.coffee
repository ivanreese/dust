Take ["ColorField", "Grid", "Particles", "Ring", "Scene", "SVG"], (ColorField, Grid, Particles, Ring, Scene, SVG)->

  lastTime = performance.now()

  requestAnimationFrame render = (time)->
    requestAnimationFrame render

    dt = Math.min 0.1, (time - lastTime) / 1000
    lastTime = time

    # UPDATE
    Take(obj.type).update? obj, dt for id, obj of Scene.objects
    Particles.update dt

    # RENDER
    Grid()
    ColorField()
    SVG.render()
    Take(obj.type).render? obj, dt for id, obj of Scene.objects
    Ring.render()
    Particles.render dt

    null
