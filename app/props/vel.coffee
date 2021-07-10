Take ["Vec2"], (Vec2)->

  template =
    vel:
      speed: 0
      friction: 100

  update = (obj, dt)->
    obj.vel.speed *= Math.clip 1 - obj.vel.friction * dt
    vel = Vec2.fromPolar obj.angle, obj.vel.speed
    obj.pos = Vec2.add obj.pos, Vec2.mulS vel, dt

  Make "vel", {template, update}
