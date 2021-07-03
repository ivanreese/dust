Take ["Canvas", "DOOM", "Scene", "SVG", "Vec2"], (Canvas, DOOM, Scene, SVG, Vec2)->

  Make "GUI", GUI =

    select: (obj)->
      obj._gui = gui = DOOM.create "g", obj.elm, class: "gui"
      DOOM.create "circle", gui, r: 128, stroke: "#6666", fill: "none", strokeWidth: 4

    deselect: (obj)->
      DOOM.remove obj._gui
