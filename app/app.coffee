Take ["Grid", "Ring", "Scene", "SVG"], (Grid, Ring, Scene, SVG)->

  lastTime = performance.now()

  requestAnimationFrame raf = (time)->
    requestAnimationFrame raf

    dt = Math.min 0.1, (time - lastTime) / 1000
    lastTime = time

    # UPDATE
    Scene.update dt

    # RENDER
    Grid dt
    SVG.render dt
    Scene.render dt
    Ring.render dt

    null
