Take ["DOOM", "Particles", "SVG", "Vec2"], (DOOM, Particles, SVG, Vec2)->

  template =
    type: "Sampler"
    elm: null
    pos: Vec2()
    radius: 8
    effectRadius: 128
    value: 0

  Make.async "Sampler", Sampler = (opts = {})->
    obj = Object.merge template, opts
    obj.elm = DOOM.create "g", SVG
    DOOM.create "circle", obj.elm, r: obj.radius, fill: "hsl(220, 50%, 50%)"
    rings = 8
    for i in [1...rings]
      alpha = Math.lerp i, 1, rings, 0.5, 0.05
      DOOM.create "circle", obj.elm, r: obj.effectRadius/i, fill: "none", stroke: "hsla(220, 50%, 50%, #{alpha})"
    return obj

  Sampler.update = (obj, dt)->
    count = 0
    for p in Particles.list
      dist = Vec2.dist p.pos, obj.pos
      count++ if dist <= obj.effectRadius
    obj.value = count

  Sampler.render = (obj)->
    DOOM obj.elm, transform: "translate(#{obj.pos.x},#{obj.pos.y})"
