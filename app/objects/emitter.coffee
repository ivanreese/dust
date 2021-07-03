Take ["Camera", "Canvas", "DOOM", "Scene", "SVG", "Vec2"], (Camera, Canvas, DOOM, Scene, SVG, Vec2)->

  template =
    type: "Emitter"
    name: "Emitter"
    pos: Vec2()
    angle: 0
    radius: 8
    spawnTime: 0.003
    spawnTimeAcc: 0
    elm: null
    particles: []

  particleTemplate =
    pos: null
    angle: 0
    speed: 0
    maxSpeed: 0
    radius: 1
    age: 0
    maxAge: 8
    color: "#3c3"


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

  Emitter.update = (obj, dt)->
    obj.spawnTimeAcc += dt

    while obj.spawnTimeAcc >= obj.spawnTime
      obj.spawnTimeAcc -= obj.spawnTime
      Scene.particles.push Object.merge particleTemplate,
        pos: Vec2.clone obj.pos
        angle: Math.rand 0, Math.TAU
        speed: speed = Math.rand 50, 100
        maxSpeed: speed
        radius: Math.rand 1, 2

  Emitter.render = (obj, dt)->
