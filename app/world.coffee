# World
# These functions do all our coordinate conversions.
# We regard world space as the most universal frame of reference.
# That's why we just call this "World" and not like "Space" or "Coords" —
# for brevity, so that we don't have to say (eg) Space.worldFromScreen.

Take ["Camera", "Vec2"], (Camera, Vec2)->

  cameraFromScreen = (pos)-> Vec2.invertY Vec2.sub pos, Vec2.halfWindow()
  screenFromCamera = (pos)-> Vec2.add Vec2.invertY(pos), Vec2.halfWindow()

  worldFromObject = (obj, pos)-> Vec2.add pos, obj.pos
  objectFromWorld = (obj, pos)-> Vec2.sub pos, obj.pos

  worldFromCamera = (pos)-> Vec2.sub pos, Camera.pos
  cameraFromWorld = (pos)-> Vec2.add pos, Camera.pos

  worldFromScreen = (pos)-> worldFromCamera cameraFromScreen pos
  screenFromWorld = (pos)-> screenFromCamera cameraFromWorld pos

  Make "World", World =
    fromScreen: worldFromScreen
    fromCamera: worldFromCamera
    fromObject: worldFromObject
    toScreen: screenFromWorld
    toCamera: cameraFromWorld
    toObject: objectFromWorld

    cameraFromScreen: cameraFromScreen
    screenFromCamera: screenFromCamera
    worldFromObject: worldFromObject
    objectFromWorld: objectFromWorld
    worldFromCamera: worldFromCamera
    cameraFromWorld: cameraFromWorld
    worldFromScreen: worldFromScreen
    screenFromWorld: screenFromWorld
