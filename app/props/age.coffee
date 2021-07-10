Take [], ()->

  template =
    age: 0

  update = (obj, dt)->
    obj.age += dt

  Make "age", {template, update}
