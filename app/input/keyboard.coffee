Take ["KeyName"], (KeyName)->
  Make.async "Keyboard", Keyboard = {}

  window.addEventListener "keydown", keyDown = (e)->
    name = KeyName e
    Keyboard[name] = true
    # If we've entered a command-FOO key chord, the FOO key doesn't automatically fire a keyup.
    # Note that by doing this, we're going to experience key repeat if the chord continues to be
    # held by the user.
    keyUp e if Keyboard.command and not isModifier name
    null

  window.addEventListener "keyup", keyUp = (e)->
    name = KeyName e
    if Keyboard[name] or isModifier name
      delete Keyboard[name]
    null

  # We need to handle modifier keys specially, because some system keyboard shortcuts don't
  # trigger keyup events, or other weird stuff happens, so we lose track of whether
  # these keys have been pressed or released if we just use keyboard events.
  isModifier = (name)-> name is "command" or name is "control" or name is "option" or name is "shift"
