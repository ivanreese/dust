Take ["Entity", "Scene", "Vec2"], (Entity, Scene, Vec2)->

  Make "emit", emit =

    template:
      emit:
        spawnTime: 0.1
        spawnTimeAcc: 0
        props: null

    update: (obj, dt)->
      return unless obj.emit.props?

      obj.emit.spawnTimeAcc += dt

      while obj.emit.spawnTimeAcc >= obj.emit.spawnTime
        obj.emit.spawnTimeAcc -= obj.emit.spawnTime

        Scene.create Entity ...obj.emit.props, pos: Vec2.clone obj.pos


      null
