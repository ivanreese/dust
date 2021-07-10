# Take ["Colors", "ColorField", "DOOM", "SVG", "Vec2", "World"], (Colors, ColorField, DOOM, SVG, Vec2, World)->
#
#   template =
#     type: "ColorSampler"
#     elm: null
#     pos: Vec2()
#     radius: 16
#     effectRadius: 16
#     value: "#000"
#
#   Make.async "ColorSampler", ColorSampler = (opts = {})->
#     obj = Object.merge template, opts
#     obj.elm = DOOM.create "g", SVG
#     DOOM.create "circle", obj.elm, r: obj.radius, stroke: Colors.fg, strokeWidth: 2
#     return obj
#
#   ColorSampler.update = (obj, dt)->
#     # We use toScreen, not toCamera, because getImageData doesn't use
#     # the canvas's transform matrix. We also need to factor in the DPI.
#     p = World.toScreen obj.pos
#     p = Vec2.mulS p, window.devicePixelRatio
#     imageData = ColorField.ctx.getImageData p.x, p.y, 1, 1
#     [r, g, b] = imageData.data
#     obj.value = "rgb(#{r},#{g},#{b})"
#
#   ColorSampler.render = (obj)->
#     DOOM obj.elm,
#       transform: "translate(#{obj.pos.x},#{obj.pos.y})"
#       fill: obj.value
