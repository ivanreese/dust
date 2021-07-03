Take ["Canvas", "DOOM", "SVG", "Vec2"], (Canvas, DOOM, SVG, Vec2)->

  template =
    type: "Emitter"
    name: "Emitter"
    pos: Vec2()
    angle: 0
    radius: 8
    elm: null

  Make.async "Emitter", Emitter = (opts = {})->
    obj = Object.merge template, opts
    obj.elm = DOOM.create "g", SVG
    DOOM.create "circle", obj.elm, r: obj.radius, fill: "#f70"

    n = 13
    rays = DOOM.create "g", obj.elm, fill: "none", stroke: "#f70", strokeWidth: 3
    for i in [0...n]
      p = Vec2.round Vec2.rotate Vec2(0, -32), Math.TAU * i/n
      DOOM.create "polyline", rays, points: "0,0 #{p.x},#{p.y}"

    return obj

  Emitter.update = (obj)->

  Emitter.render = (obj)->
