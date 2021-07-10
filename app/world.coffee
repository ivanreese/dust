# World
# These functions do all our coordinate conversions.
# We regard world space as the most universal frame of reference.
# That's why we just call this "World" and not like "Space" or "Coords" —
# for brevity, so that we don't have to say (eg) Space.worldFromScreen.

Take ["Camera", "Vec2"], (Camera, Vec2)->

  cameraFromScreen = (pos = Vec2.zero)-> Vec2.sub pos, Vec2.halfWindow()
  screenFromCamera = (pos = Vec2.zero)-> Vec2.add pos, Vec2.halfWindow()

  objectFromWorld = (obj, pos = Vec2.zero)-> Vec2.sub pos, obj.pos
  worldFromObject = (obj, pos = Vec2.zero)-> Vec2.add pos, obj.pos

  worldFromCamera = (pos = Vec2.zero)-> Vec2.sub pos, Camera.pos
  cameraFromWorld = (pos = Vec2.zero)-> Vec2.add pos, Camera.pos

  worldFromScreen = (pos = Vec2.zero)-> worldFromCamera cameraFromScreen pos
  screenFromWorld = (pos = Vec2.zero)-> screenFromCamera cameraFromWorld pos

  Make "World", World =
    fromScreen: worldFromScreen
    fromCamera: worldFromCamera
    fromObject: worldFromObject
    toScreen: screenFromWorld
    toCamera: cameraFromWorld
    toObject: objectFromWorld

    # For debugging
    # cameraFromScreen: cameraFromScreen
    # screenFromCamera: screenFromCamera
    # worldFromObject: worldFromObject
    # objectFromWorld: objectFromWorld
    # worldFromCamera: worldFromCamera
    # cameraFromWorld: cameraFromWorld
    # worldFromScreen: worldFromScreen
    # screenFromWorld: screenFromWorld
