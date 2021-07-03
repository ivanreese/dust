Take ["Canvas", "DOOM", "Scene", "SVG", "Vec2"], (Canvas, DOOM, Scene, SVG, Vec2)->

  template =
    type: "Push"
    name: "Push"
    pos: Vec2()
    angle: 0
    strength: 100
    radius: 8
    effectRadius: 128
    elm: null

  Make.async "Push", Push = (opts = {})->
    obj = Object.merge template, opts
    obj.elm = DOOM.create "g", SVG
    DOOM.create "circle", obj.elm, r: obj.radius, fill: "#f70"
    DOOM.create "circle", obj.elm, r: obj.effectRadius, fill: "none", stroke: "#f701"
    DOOM.create "path", obj.elm, fill: "none", stroke: "#f70", strokeWidth: 3, d: "M0,0 L96,0 M80,16 L96,0 L80,-16"
    return obj

  Push.update = (obj, dt)->
    forceVec = Vec2.fromPolar obj.angle, obj.strength

    for p in Scene.particles
      dist = Vec2.dist p.pos, obj.pos
      if dist <= obj.effectRadius
        scale = 1 - (dist / obj.effectRadius)**4
        distScaledForceVec = Vec2.mulS forceVec, scale
        vel = Vec2.fromPolar p.angle, p.speed
        vel = Vec2.add vel, Vec2.mulS distScaledForceVec, dt
        len = Vec2.len vel
        if len > p.maxSpeed
          vel = Vec2.mulS vel, p.maxSpeed / len
          len = p.maxSpeed
        p.angle = Vec2.angle vel
        p.speed = len



    null

  Push.render = (obj)->
