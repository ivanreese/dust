Take ["Camera", "DOOM"], (Camera, DOOM)->
  elm = DOOM.create "svg", document.body

  Make.async "SVG", SVG = DOOM.create "g", elm,
    id: "root"
    transform: "translate(-0.5,-0.5) scale(1, -1)"

  SVG.render = ()->
    DOOM SVG, transform: "translate(#{Camera.pos.x+window.innerWidth/2-0.5}, #{-Camera.pos.y+window.innerHeight/2-0.5}) scale(1, -1)"
