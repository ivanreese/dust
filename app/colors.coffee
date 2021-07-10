Take [], ()->

  # Grab colors from the CSS, which are set using custom properties (aka CSS variables)
  get = (k)-> getComputedStyle(document.documentElement).getPropertyValue "--#{k}"

  Make.async "Colors", Colors = {}

  setup = ()->
    Colors.bg = get "bg"
    Colors.fg = get "fg"
    Colors.grid =
      axis: get "grid-axis"
      dot: get "grid-dot"
    Colors.particle = get "particle"

  window.matchMedia("(prefers-color-scheme: dark)").addListener setup
  setup()
