# This our main loop
Take ["Canvas", "Grid", "Scene", "SVG"], (Canvas, Grid, Scene, SVG)->
  requestAnimationFrame render = ()->
    requestAnimationFrame render
    for obj in Scene.objects
      Take(obj.type).update? obj
      DOOM obj.elm, transform: "translate(#{obj.pos.x},#{obj.pos.y}) rotate(#{obj.angle*360/Math.TAU})"
    Canvas.clear()
    Grid()
    SVG.render()
    Take(obj.type).render? obj for obj in Scene.objects
    null

# This sets up test data
Take ["Emitter", "Push", "Scene"], (Emitter, Push, Scene)->
  Scene.objects.push Emitter pos: x: -128
  Scene.objects.push Push pos: x: 128
