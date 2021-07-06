Take ["Camera", "Canvas", "Colors", "Vec2"], (Camera, Canvas, Colors, Vec2)->

  ctx = Canvas style: "z-index: 0"
  minor = 32
  major = 4 * minor
  snap = (v)-> Math.roundTo v, minor

  Make.async "Grid", Grid = ()->
    camera = Camera.pos
    half = Vec2.halfWindow()

    # First, convert the corners of the screen into worldspace
    left   = -half.x - camera.x
    right  =  half.x - camera.x
    top    =  half.y - camera.y
    bottom = -half.y - camera.y

    ctx.clear()

    ctx.beginPath()
    ctx.fillStyle = Colors.grid.dot

    # We align to the grid by snapping the corners and looping through all visible positions
    for x_world in [snap(left)..snap(right)] by minor when x_world > left and x_world < right
      isAxisX = x_world is 0
      isMajorX = x_world % major is 0
      x = x_world + camera.x

      for y_world in [snap(bottom)..snap(top)] by minor when y_world > bottom and y_world < top
        isAxisY = y_world is 0
        isMajorY = y_world % major is 0
        y = y_world + camera.y

        # Use a bigger dot if we're on a major grid row & col
        radius = if isMajorX and isMajorY then 1.6 else .6

        # Apply a falloff as we approach the edge of the screen
        r = radius * edgeScale x, y, half

        if isMajorX and isMajorY
          ctx.circle x, y, r
        else
          ctx.sharpRect x-r, y-r, r*2, r*2

    ctx.fill()


  edgeScale = (x, y, half)->
    # Take the x and y, which ramp from low to high pixel coords across the screen (/-shaped),
    # and scale them to the range -0.5 to 0.5
    x = Math.lerp x, -half.x, half.x, -0.5, 0.5
    y = Math.lerp y, -half.y, half.y, -0.5, 0.5
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
