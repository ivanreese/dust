# Take ["Canvas", "Colors", "DOOM", "Vec2", "World", "DOMContentLoaded"], (Canvas, Colors, DOOM, Vec2, World)->
#
#   ctx = Canvas style: "z-index: 10"
#
#   img = DOOM.create "img", document.body, style: "display: none", src: "color-field.jpg"
#   await new Promise (resolve)-> img.onload = resolve
#
#   pos = Vec2 512, -256
#
#   Make.async "ColorField", ColorField = ()->
#     ctx.clear()
#
#     p = World.toCamera pos
#
#     ctx.beginPath()
#     ctx.fillStyle = Colors.bg
#     ctx.sharpRect p.x-2, p.y-2, 516, 516
#     ctx.fill()
#     ctx.drawImage img, p.x+6, p.y+6
#
#   ColorField.ctx = ctx
