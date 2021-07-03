Take ["Camera", "Canvas", "Colors"], (Camera, Canvas, Colors)->

  minor = 32
  major = 4 * minor
  snap = (v)-> Math.roundTo v, minor

  Make.async "Grid", Grid = ()->
    ctx = Canvas.ctx
    screen = Canvas.size
    camera = Camera.pos

    # Dot grid

    # First, convert the corners of the screen into worldspace
    left   = -screen.hw - camera.x
    right  =  screen.hw - camera.x
    top    =  screen.hh - camera.y
    bottom = -screen.hh - camera.y

    # Axis lines
    # step = 4
    # for x in [-screen.hw..screen.hw] by step
    #   line ctx, x, camera.y, x+step, camera.y, Colors.grid.axis, 2 * edgeScale x+step/2, camera.y, screen
    # for y in [-screen.hh..screen.hh] by step
    #   line ctx, camera.x, y, camera.x, y+step, Colors.grid.axis, 2 * edgeScale camera.x, y+step/2, screen


    # We align to the grid by snapping the corners and looping through all visible positions
    for x_world in [snap(left)..snap(right)] by minor when x_world > left and x_world < right
      isAxisX = x_world is 0
      isMajorX = x_world % major is 0
      x = x_world + camera.x

      for y_world in [snap(bottom)..snap(top)] by minor when y_world > bottom and y_world < top
        isAxisY = y_world is 0
        isMajorY = y_world % major is 0
        y = y_world + camera.y

        # From here on out, everything happens in screenspace

        # Use a bigger dot if we're on a major grid row & col
        radius = if isMajorX and isMajorY then 1.6 else .6

        # Apply a falloff as we approach the edge of the screen
        r = radius * edgeScale x, y, screen

        # # If we're drawing on top of an axis line, punch a little "halo" circle out of the axis line
        # if isAxisX and isMajorY or isAxisY and isMajorX
        #   circle ctx, x, y, 2+r, Colors.bg

        # Don't bother drawing the smaller grid dots along the axis lines
        # continue if isAxisX and not isMajorY or isAxisY and not isMajorX

        if isMajorX and isMajorY
          circle ctx, x, y, r, Colors.grid.dot
        else
          rect ctx, x-r, y-r, r*2, r*2, Colors.grid.dot
    null

  circle = (ctx, x, y, r, c)->
    ctx.beginPath()
    ctx.fillStyle = c
    ctx.arc x-0.5, y-0.5, r, 0, Math.TAU
    ctx.fill()

  rect = (ctx, x, y, w, h, c)->
    ctx.beginPath()
    ctx.fillStyle = c
    ctx.fillRect x-0.5, y-0.5, w, h

  line = (ctx, x1, y1, x2, y2, c, w = 1)->
    ctx.beginPath()
    ctx.strokeStyle = c
    ctx.lineWidth = w
    ctx.moveTo x1-0.5, y1-0.5
    ctx.lineTo x2-0.5, y2-0.5
    ctx.stroke()

  edgeScale = (x, y, screen)->
    # Take the x and y, which ramp from low to high pixel coords across the screen (/-shaped),
    # and scale them to the range -0.5 to 0.5
    x = Math.lerp x, -screen.hw, screen.hw, -0.5, 0.5
    y = Math.lerp y, -screen.hh, screen.hh, -0.5, 0.5
    # Use abs to make the range \/-shaped, then take the larger (closest to edge) component
    scale = Math.max Math.abs(x), Math.abs(y)
    # Invert (/\-shaped), and scale so the peak is 4 units high
    scale = Math.lerp scale, 0, .5, 4, 0
    # Crop the peak (/‾‾‾\-shaped)
    scale = Math.min scale, 1
    # Apply an exponential ease-in curve, so that we start fading slowly then fade faster as we approach the edge
    scale = scale ** 0.5
    return scale

  Grid.snap = snap
