Take [], ()->

  Make "Scene", Scene =
    objects: []
    selected: null

    select: (selected)->
      Scene.selected = selected
      selected
