Take ["Canvas", "SVG"], (Canvas, SVG)->

  instances = []

  requestAnimationFrame render = ()->
    requestAnimationFrame render

    for inst in instances
      Take(inst.type).update? inst, instances

    Canvas.clear()
    SVG.render()

    for inst in instances
      Take(inst.type).render? inst, instances

    null

  Take ["Emitter", "Grid"], (Emitter, Grid)->
    instances.push Grid()
    instances.push Emitter()
