Take ["DOOM", "World"], (DOOM, World)->
  elm = DOOM.create "svg", document.body, style: "z-index: 70"

  Make.async "SVG", SVG = DOOM.create "g", elm, id: "root", fill: "none"

  SVG.render = ()->
    p = World.toScreen()
    DOOM SVG, transform: "translate(#{p.x - .5}, #{p.y - .5})"
