Take [], ()->

  Make "Scene", Scene =
    objects: []
    particles: []
    selection: []

    select: (...selection)->
      for obj in Scene.selection
        Take("GUI").deselect obj

      Scene.selection = selection.flat().filter Function.exists

      for obj in Scene.selection
        Take("GUI").select obj
