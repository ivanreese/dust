Take ["Vec2"], (Vec2)->

  Make "randomize", randomize =
    template:
      randomize: {}

    create: (obj)->
      for k, {type = "rand", min, max} of obj.randomize
        obj[k] = Math[type] min, max
