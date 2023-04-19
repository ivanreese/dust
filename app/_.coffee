Take ["Entity", "emit", "Scene"], (Entity, emit, Scene)->
  # Scene.create Entity "vel", angle: Math.PI/3, pos: {x: 192}
  # Scene.create Entity "vel", "push", angle: 0, pos: {x: 0}
  # Scene.create Entity "vel", angle: -Math.PI/3, pos: {x: -192}

  # Each prop should have a control — 1-to-1 mapping.
  # Angle = Rotate
  # Basically like widgets in that CMS.

  Scene.create Entity "emit",
    emit:
      spawnTime: 0.5
      spawnTimeAcc: 0.5
      props: [
        "vel"
        "die"
        {
          push:
            strength: 100
            effectRadius: 12
        }
        {
          vel:
            speed: 50
            friction: 0.1
        }
        {
          randomize:
            angle:
              min: 0
              max: Math.TAU
        }
      ]
