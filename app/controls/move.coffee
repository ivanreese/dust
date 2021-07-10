Take ["Colors", "DOOM", "Grid", "Keyboard", "Ring", "Vec2"], (Colors, DOOM, Grid, Keyboard, Ring, Vec2)->

  elm = DOOM.create "g", null, strokeWidth: 2
  DOOM.create "circle", elm, r: 12, fill: Colors.fg
  DOOM.create "path", elm, stroke: Colors.bg, d: "M0,-5 L0,5 M-5,0 L5,0"
  DOOM.create "path", elm, fill: Colors.bg, d: "M-9,0 L-5,3 L-5,-3  M9,0 L5,3 L5,-3  M0,9 L3,5 L-3,5  M0,-9 L3,-5 L-3,-5"

  Ring.controlReady "Move", elm, Move =

    change: (obj, mouse, delta)->
      mouse = Vec2.map Grid.snap, mouse if Keyboard.option
      obj.pos = mouse
