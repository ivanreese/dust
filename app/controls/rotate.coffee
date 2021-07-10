Take ["Colors", "DOOM", "Ring"], (Colors, DOOM, Ring)->

  elm = DOOM.create "g", null, strokeWidth: 2
  DOOM.create "circle", elm, r: 12, fill: Colors.fg
  DOOM.create "path", elm, stroke: Colors.bg, d: "M-6,0 A6,6 270 1 1 0 6"
  DOOM.create "path", elm, fill: Colors.bg, d: "M0,3 L-5,6 L0,9"

  startAngle = null

  getAngle = (obj, mouse)->
    dx = mouse.x - obj.pos.x
    dy = mouse.y - obj.pos.y
    Math.atan2 dy, dx

  Ring.controlReady "Rotate", elm, Rotate =
    start: (obj, mouse)->
      startAngle = getAngle(obj, mouse) - obj.angle

    change: (obj, mouse, delta)->
      obj.angle = getAngle(obj, mouse) - startAngle

    stop: ()->
      startAngle = null
