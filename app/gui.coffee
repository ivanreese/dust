Take ["Canvas", "DOOM", "Scene", "SVG", "Vec2"], (Canvas, DOOM, Scene, SVG, Vec2)->

  Make "GUI", GUI =

    select: (obj)->
      obj._gui = gui = DOOM.create "g", null, class: "gui", fill: "none"

      DOOM.create "circle", gui, r: 128, stroke: "#666", fill: "var(--bg)", fillOpacity: 0.5, strokeWidth: 4

      rotate = DOOM.create "g", gui, transform: "translate(0, 128)", strokeWidth: 2
      DOOM.create "circle", rotate, r: 12, fill: "#f07"
      DOOM.create "path", rotate, stroke: "black", d: "M-6,0 A6,6 270 1 1 0 6"
      DOOM.create "path", rotate, fill: "black", d: "M0,3 L-5,6 L0,9"

      DOOM.prepend obj.elm, gui
      DOOM.append obj.elm.parentElement, obj.elm # Bring to front


    deselect: (obj)->
      DOOM.remove obj._gui
