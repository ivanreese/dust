Take ["Canvas"], (Canvas)->

  ctx = Canvas style: "z-index: 51"

  Make "Scene", Scene =
    nextId: 0
    objects: {}
    selected: null

    create: (obj)->
      obj.id = Scene.nextId++ unless obj.id?
      Scene.objects[obj.id] = obj
      obj

    destroy: (obj)->
      # TODO: make sure this object is deselected
      delete Scene.objects[obj.id]
      obj

    select: (obj)->
      Scene.selected = obj
      obj

    update: (dt)->
      count = 0
      for id, obj of Scene.objects
        count++
        for name, prop of obj
          Take(name)?.update? obj, dt

    render: (dt)->
      ctx.clear()
      for id, obj of Scene.objects
        Take(obj.type).render? obj, dt, ctx
