Take ["ColorSampler", "Emitter", "Push", "Sampler", "Scene"], (ColorSampler, Emitter, Push, Sampler, Scene)->
  Scene.create ColorSampler id: "Color", pos: x: 600, y: 128
  Scene.create Sampler id: "Radius", pos: x: 128, y: 128
  Scene.create Emitter samplers: radius: "Radius", color: "Color"
  Scene.create Push angle: Math.PI, pos: x: 192
  Scene.create Push angle: -Math.PI/2, pos: y: 192
  Scene.create Push angle: 0, pos: x: -192
  Scene.create Push angle: Math.PI/2, pos: y: -192
