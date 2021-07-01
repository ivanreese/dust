Take ["DOOM", "SVG", "Vec2"], (DOOM, SVG, Vec2)->

  template =
    type: "Emitter"
    name: "Emitter"
    pos: Vec2()
    angle: 0
    elm: null

  Make.async "Emitter", Emitter = (opts = {})->
    inst = Object.merge template, opts
    inst.elm = DOOM.create "g", SVG
    DOOM.create "circle", inst.elm, r: "5", fill: "#f70"
    DOOM.create "rect", inst.elm, width:"2", height:"50", x:"-1", y:"0", fill: "#f70"
    return inst

  Emitter.update = (inst)->
    # blah

  Emitter.render = (ctx, inst)->
    
