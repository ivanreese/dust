Take ["Scene", "Vec2"], (Scene, Vec2)->

  Make "push", push =
    template:
      push:
        strength: 1000
        effectRadius: 128

    update: (obj, dt)->
      forceVec = Vec2.fromPolar obj.angle, obj.push.strength

      for id, other of Scene.objects when other isnt obj
        continue unless other.vel?

        dist = Vec2.dist other.pos, obj.pos

        if dist <= obj.push.effectRadius
          scale = 1 - (dist / obj.push.effectRadius)**4
          distScaledForceVec = Vec2.mulS forceVec, scale
          vel = Vec2.fromPolar other.angle, other.vel.speed
          vel = Vec2.add vel, Vec2.mulS distScaledForceVec, dt
          other.angle = Vec2.angle vel
          other.vel.speed = Vec2.len vel

      null
