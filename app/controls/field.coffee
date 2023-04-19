Take ["Colors", "DOOM", "Ring"], (Colors, DOOM, Ring)->

  elm = DOOM.create "g", null
  DOOM.create "rect", elm, width: 40, height: 20, rx: 10, ry: 10, fill: Colors.fg

  startValue = null

  getAngle = (obj, mouse)->
    dx = mouse.x - obj.pos.x
    dy = mouse.y - obj.pos.y
    Math.atan2 dy, dx

  Ring.controlReady "Field", elm, Field =
    start: (obj, mouse)->
      # startValue =

    change: (obj, mouse, delta)->
      # obj[k] =

    stop: ()->
      startValue = null
