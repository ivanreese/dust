Take [], ()->

  # Grab colors from the CSS, which are set using custom properties (aka CSS variables)
  get = (k)-> getComputedStyle(document.documentElement).getPropertyValue "--#{k}"

  Make "Colors", Colors =
    bg: get "bg"
    grid:
      axis: get "grid-axis"
      dot: get "grid-dot"
