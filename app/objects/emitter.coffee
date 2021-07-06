Take ["DOOM", "Particles", "Scene", "SVG", "Vec2"], (DOOM, Particles, Scene, SVG, Vec2)->

  template =
    type: "Emitter"
    elm: null
    pos: Vec2()
    angle: 0
    radius: 8
    spawnTime: 0.1
    spawnTimeAcc: 0
    samplers: {}

  particleTemplate =
    pos: null
    angle: 0
    speed: 0
    maxSpeed: 0
    radius: 1
    age: 0
    maxAge: 4
    color: "#3c3"
    alpha: 0


  Make.async "Emitter", Emitter = (opts = {})->
    obj = Object.merge template, opts
    obj.elm = DOOM.create "g", SVG
    DOOM.create "circle", obj.elm, r: obj.radius, fill: "#f70"

    n = 13
    rays = DOOM.create "g", obj.elm, fill: "none", stroke: "#f70", strokeWidth: 1
    for i in [0...n]
      p = Vec2.round Vec2.rotate Vec2(0, -32), Math.TAU * i/n
      DOOM.create "polyline", rays, points: "0,0 #{p.x},#{p.y}"

    return obj

  angle = 0

  Emitter.update = (obj, dt)->
    obj.spawnTimeAcc += dt

    while obj.spawnTimeAcc >= obj.spawnTime
      obj.spawnTimeAcc -= obj.spawnTime

      opts =
        pos: Vec2.clone obj.pos
        angle: angle++ / 71
        speed: 300
        maxSpeed: 300
        color: "hsl(0, 100%, #{Math.randInt(95, 100)}%"

      if s = Scene.objects[obj.samplers.radius]
        opts.radius = Math.lerp s.value, 0, 100, 2, 10, true

      if s = Scene.objects[obj.samplers.color]
        opts.color = s.value

      Particles.list.push Object.merge particleTemplate, opts

  Emitter.render = (obj, dt)->
    DOOM obj.elm, transform: "translate(#{obj.pos.x},#{obj.pos.y}) rotate(#{obj.angle*360/Math.TAU})"
