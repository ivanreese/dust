Take ["Canvas", "Vec2"], (Canvas, Vec2)->

  Make.async "Camera", Camera =
    pos: Vec2()
    move: (delta)-> Camera.pos = Vec2.add Camera.pos, delta
