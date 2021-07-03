Take ["Canvas", "DOOM", "SVG", "Vec2"], (Canvas, DOOM, SVG, Vec2)->

  template =
    type: "Push"
    name: "Push"
    pos: Vec2()
    angle: 0
    radius: 8
    elm: null

  Make.async "Push", Push = (opts = {})->
    obj = Object.merge template, opts
    obj.elm = DOOM.create "g", SVG
    DOOM.create "circle", obj.elm, r: obj.radius, fill: "#f70"
    DOOM.create "path", obj.elm, fill: "none", stroke: "#f70", strokeWidth: 3, d: "M0,0 L0,96 M16,80 L0,96 L-16,80"
    return obj

  Push.update = (obj)->
    # blah

  Push.render = (obj)->
