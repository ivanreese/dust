Take ["Colors", "DOOM", "SVG", "Vec2"], (Colors, DOOM, SVG, Vec2)->

  selected = null

  bg = DOOM.create "circle", null, r: 64, stroke: Colors.fg, strokeOpacity: .1, strokeWidth: 4
  ring = DOOM.create "g", null, class: "ring"

  # List all the controls in the ring, and the index that will be used to position them
  controls =
    Move: index: -1 # The move control is positioned specially
    Rotate: index: 0


  getPos = (index)->
    if index < 0
      Vec2()
    else
      angle = Math.TAU * Math.lerp index, 0, 12, -0.25, 0.75, false
      Vec2.fromPolar angle, 64


  Make "Ring", Ring =
    controlReady: (name, elm, api)->
      control = controls[name]
      control.elm = elm
      control.api = api
      control.pos = getPos control.index
      DOOM elm, transform: "translate(#{control.pos.x},#{control.pos.y})"
      DOOM.append ring, elm

    select: (obj, mouse)->
      selected = obj
      DOOM.append SVG, bg
      DOOM.append SVG, obj.elm if obj.elm
      DOOM.append SVG, ring

    getControlAt: (mouse)->
      for name, control of controls
        if Vec2.dist(mouse, control.pos) < 8
          return control.api
      null

    deselect: ()->
      selected = null
      DOOM.remove ring
      DOOM.remove bg

    render: ()->
      return unless selected?
      pos = selected.pos
      DOOM bg, transform: "translate(#{pos.x},#{pos.y})"
      DOOM ring, transform: "translate(#{pos.x},#{pos.y})"
