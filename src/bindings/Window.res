@scope("window") @val
external addWindowEventListener: (string, ReactEvent.Keyboard.t => unit) => unit =
  "addEventListener"
@scope("window") @val
external removeWindowEventListener: (string, ReactEvent.Keyboard.t => unit) => unit =
  "removeEventListener"
