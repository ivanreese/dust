do ()->

  # Constructors
  Vec2 = (x=0, y=0)-> x:x, y:y
  Vec2.clone = (v)-> Vec2 v.x, v.y
  Vec2.fromRectXY = (r)-> Vec2 r.x, r.y
  Vec2.fromRectWH = (r)-> Vec2 r.w, r.h
  Vec2.fromRectRB = (r)-> Vec2 r.x+r.w, r.y+r.h
  Vec2.of = (s)-> Vec2 s, s
  Vec2.random = ()-> Vec2.complement Vec2.Smul 2, Vec2 Math.random(), Math.random()
  Vec2.toA = (v)-> [v.x, v.y]

  # Static Vectors
  Vec2.x = Object.freeze Vec2 1
  Vec2.y = Object.freeze Vec2 0, 1
  Vec2.zero = Object.freeze Vec2()

  # FP
  Vec2.map = (f, v)-> Vec2 f(v.x), f(v.y)
  Vec2.map2 = (f, a, b)-> Vec2 f(a.x, b.x), f(a.y, b.y)
  Vec2.reduce = (f, v)-> f v.x, v.y

  # Vector Algebra
  Vec2.cross = ()-> throw "There is no cross product in 2D"
  Vec2.project = (a, b)-> Vec2.mulS b, Vec2.dot(a, b) / Vec2.len2 b
  Vec2.reject = (a, b)-> Vec2.sub a, Vec2.project a, b

  # Piecewise Vector Arithmetic
  Vec2.add = (a, b)-> Vec2.map2 Math.add, a, b
  Vec2.div = (a, b)-> Vec2.map2 Math.div, a, b
  Vec2.mul = (a, b)-> Vec2.map2 Math.mul, a, b
  Vec2.sub = (a, b)-> Vec2.map2 Math.sub, a, b

  # Vector-Scalar Arithmetic
  Vec2.addS = (v, s)-> Vec2.add v, Vec2.of(s)
  Vec2.divS = (v, s)-> Vec2.div v, Vec2.of(s)
  Vec2.mulS = (v, s)-> Vec2.mul v, Vec2.of(s)
  Vec2.subS = (v, s)-> Vec2.sub v, Vec2.of(s)

  # Scalar-Vector Arithmetic
  Vec2.Sadd = (s, v)-> Vec2.add Vec2.of(s), v
  Vec2.Sdiv = (s, v)-> Vec2.div Vec2.of(s), v
  Vec2.Smul = (s, v)-> Vec2.mul Vec2.of(s), v
  Vec2.Ssub = (s, v)-> Vec2.sub Vec2.of(s), v

  # Measurement
  Vec2.dist = (a, b)-> Vec2.len Vec2.sub a, b
  Vec2.dist2 = (a, b)-> Vec2.len2 Vec2.sub a, b
  Vec2.dot = (a, b)-> a.x * b.x + a.y * b.y
  Vec2.equal = (a, b)-> Math.zero Vec2.dist2 a, b
  Vec2.len2 = (v)-> Vec2.dot v, v
  Vec2.len = (v)-> Math.sqrt Vec2.dot v, v

  # Rounding
  Vec2.ceil = (v)-> Vec2.map Math.ceil, v
  Vec2.floor = (v)-> Vec2.map Math.floor, v
  Vec2.round = (v)-> Vec2.map Math.round, v
  Vec2.roundTo = (v, s)-> Vec2.map2 Math.roundTo, v, Vec2.of(s)

  # Variations
  Vec2.complement = (v)-> Vec2.Ssub 1, v
  Vec2.half = (v)-> Vec2.divS v, 2
  Vec2.normalize = (v)-> Vec2.divS v, Vec2.len v
  Vec2.recip = (v)-> Vec2.Sdiv 1, v
  Vec2.renormalize = (v,im,iM,om,oM)-> Vec2.add(Vec2.mul(Vec2.div(Vec2.sub(v,im),Vec2.sub(iM,im)),Vec2.sub(oM,om)),om)

  # Combinations
  Vec2.avg = (a, b)-> Vec2.half Vec2.add a, b
  Vec2.lerp = (a, b, t)-> Vec2.add a, Vec2.Smul t, Vec2.sub b, a
  Vec2.max = (a, b)-> Vec2.map2 Math.max, a, b
  Vec2.min = (a, b)-> Vec2.map2 Math.min, a, b

  # Reflections
  Vec2.abs = (v)-> Vec2.map Math.abs, v
  Vec2.invert  = (v)-> Vec2 -v.x, -v.y
  Vec2.invertX = (v)-> Vec2 -v.x,  v.y
  Vec2.invertY = (v)-> Vec2  v.x, -v.y

  # Transformations
  Vec2.rotate = (v, a)->
    c = Vec2.mulS v, Math.cos a
    s = Vec2.mulS v, Math.sin a
    Vec2 c.x + s.y, s.x - c.y

  Make "Vec2", Vec2
