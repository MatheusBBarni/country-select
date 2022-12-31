%%raw(`import '../styles/SearchInput.scss'`)

open RadixIcons

@react.component
let make = (~value: string, ~onChange: string => unit) => {
  let handleInputChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]

    onChange(value)
  }

  <div className="search-input">
    <MagnifyingGlassIcon width=20 height=20 />
    <input value onChange=handleInputChange placeholder="Search" />
  </div>
}
