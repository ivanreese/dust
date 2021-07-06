Take ["Emitter", "Push", "Sampler", "Scene"], (Emitter, Push, Sampler, Scene)->
  Scene.objects.push Sampler name: "Radius", pos: x: 128, y: 128
  Scene.objects.push Emitter samplers: radius: "Radius"
  Scene.objects.push Push angle: Math.PI, pos: x: 192
  Scene.objects.push Push angle: -Math.PI/2, pos: y: 192
  Scene.objects.push Push angle: 0, pos: x: -192
  Scene.objects.push Push angle: Math.PI/2, pos: y: -192
