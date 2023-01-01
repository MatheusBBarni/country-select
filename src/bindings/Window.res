module type EventListenerConfig = {
  type eventType
  let eventName: string
}

module MakeEventListener = (E: EventListenerConfig) => {
  @scope("window") @val
  external addWindowEventListener: (string, E.eventType => unit) => unit = "addEventListener"
  @scope("window") @val
  external removeWindowEventListener: (string, E.eventType => unit) => unit = "removeEventListener"

  let addWindowEventListener = (fn: E.eventType => unit) => addWindowEventListener(E.eventName, fn)
  let removeWindowEventListener = (fn: E.eventType => unit) =>
    removeWindowEventListener(E.eventName, fn)
}
