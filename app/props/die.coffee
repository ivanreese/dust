Take ["Scene", "Vec2"], (Scene, Vec2)->

  template =
    age: 0
    scale: 1
    die:
      at: 1
      fade: 1
      scale: null

  update = (obj, dt)->
    if obj.age >= obj.die.at
      obj.die.scale ?= obj.scale
      obj.scale = Math.lerp obj.age - obj.die.at, 0, obj.die.fade, obj.die.scale, 0
    if obj.scale <= 0
      Scene.destroy obj

  Make "die", {template, update}
