Take ["DOOM", "Grid", "Keyboard", "Ring", "Vec2"], (DOOM, Grid, Keyboard, Ring, Vec2)->

  elm = DOOM.create "g", null, strokeWidth: 2
  DOOM.create "circle", elm, r: 12, fill: "#f07"
  DOOM.create "path", elm, stroke: "black", d: "M0,-9 L0,9 M-9,0 L9,0"

  Ring.controlReady "Move", elm, Move =
  
    change: (obj, mouse, delta)->
      mouse = Vec2.map Grid.snap, mouse if Keyboard.option
      obj.pos = mouse
