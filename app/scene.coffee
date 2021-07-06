Take [], ()->

  id = 0

  Make "Scene", Scene =
    count: 0
    objects: {}
    selected: null

    create: (obj)->
      obj.id = id++ unless obj.id?
      Scene.objects[obj.id] = obj
      Scene.count++
      obj

    destroy: (obj)->
      delete Scene.objects[obj.id]
      Scene.count--
      obj

    select: (obj)->
      Scene.selected = obj
      obj
