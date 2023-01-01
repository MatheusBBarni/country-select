%%raw(`import '../styles/SearchInput.scss'`)

open RadixIcons

@send external focus: Dom.element => unit = "focus"

module EventListener = Window.MakeEventListener({
  type eventType = ReactEvent.Keyboard.t
  let eventName = "keydown"
})

@react.component
let make = (~value: string, ~onChange: string => unit) => {
  let inputRef = React.useRef(Js.Nullable.null)

  // Workaround to prevent radix/select element default behavior
  React.useEffect0(() => {
    let handleKeyDown = event => {
      let keysToIgnore = ["ArrowDown", "ArrowUp", "Enter"]

      let target = event->ReactEvent.Keyboard.target
      let key = event->ReactEvent.Keyboard.key
      let classList = target["classList"]->Belt.Array.map(elementClass => elementClass)

      if (
        !(keysToIgnore->Js.Array2.includes(key)) &&
        (classList->Js.Array2.includes("country-select__item") ||
          classList->Js.Array2.includes("country-select__content"))
      ) {
        inputRef.current->Js.Nullable.toOption->Belt.Option.forEach(input => input->focus)
      }

      ()
    }

    EventListener.addWindowEventListener(handleKeyDown)

    Some(() => EventListener.removeWindowEventListener(handleKeyDown))
  })

  let handleInputChange = React.useCallback1(event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]

    onChange(value)
  }, [onChange])

  <div className="search-input">
    <MagnifyingGlassIcon width=20 height=20 />
    <input
      value
      onChange=handleInputChange
      placeholder="Search"
      type_="text"
      autoComplete="off"
      ref={inputRef->ReactDOM.Ref.domRef}
    />
  </div>
}

let make = React.memo(make)
