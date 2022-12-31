%%raw(`import '../styles/SearchInput.scss'`)

open Window
open RadixIcons

@send external focus: Dom.element => unit = "focus"

@react.component
let make = (~value: string, ~onChange: string => unit) => {
  let inputRef = React.useRef(Js.Nullable.null)

  // Workaround to prevent radix/select element default behavior
  React.useEffect0(() => {
    let handleKeyDown = event => {
      let target = event->ReactEvent.Keyboard.target
      let classList = target["classList"]->Belt.Array.map(elementClass => elementClass)

      if (
        classList->Js.Array2.includes("country-select__item") ||
          classList->Js.Array2.includes("country-select__content")
      ) {
        inputRef.current->Js.Nullable.toOption->Belt.Option.forEach(input => input->focus)
      }

      ()
    }

    addWindowEventListener("keydown", handleKeyDown)

    Some(() => removeWindowEventListener("keydown", handleKeyDown))
  })

  let handleInputChange = React.useCallback2(event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]

    onChange(value)
  }, (onChange, inputRef))

  <div className="search-input">
    <MagnifyingGlassIcon width=20 height=20 />
    <input
      id="search-input"
      value
      onChange=handleInputChange
      placeholder="Search"
      type_="text"
      ref={inputRef->ReactDOM.Ref.domRef}
    />
  </div>
}
