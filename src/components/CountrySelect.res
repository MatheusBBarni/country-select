%%raw(`import '../styles/CountrySelect.scss'`)

open Renderer
open Radix
open RadixIcons

// <span className="fi fi-br" />

module SelectItem = {
  @react.component
  let make = (~value: string, ~label: string) => {
    <Select.Item className="country-select__item" value>
      <Select.ItemText>
        <span className={`fi fi-${value}`} />
        {label->React.string}
      </Select.ItemText>
      <Select.ItemIndicator className="country-select__item__indicator">
        <CheckIcon />
      </Select.ItemIndicator>
    </Select.Item>
  }
}

@react.component
let make = (~className: string, ~country: option<string>, ~onChange: string => unit) => {
  let (countries, loading, error) = UseCountries.make()

  Js.log3(countries, loading, error)

  <div className={`country-select ${className}`}>
    <Select.Root
      value={switch (loading, error, countries) {
      | (true, false, Empty) => None
      | (false, true, Empty) => None
      | _ => country
      }}
      onClick={_ => Js.log("123")}
      onValueChange=onChange>
      <Select.Trigger className="country-select__trigger">
        <Select.Value placeholder="Select a country" />
        <Select.Icon className="country-select__icon">
          <ChevronDownIcon />
        </Select.Icon>
      </Select.Trigger>
      <Select.Portal>
        <Select.Content className="country-select__content">
          <input />
          <Select.ScrollUpButton className="country-select__scroll-button">
            <ChevronUpIcon />
          </Select.ScrollUpButton>
          <Select.Viewport className="country-select__viewport">
            {switch countries {
            | Empty => <SelectItem value="" label="No countries" />
            | Data(countries) =>
              countries->map(country => {
                <SelectItem key={country.value} value={country.value} label={country.label} />
              })
            }}
          </Select.Viewport>
          <Select.ScrollDownButton className="country-select__scroll-button">
            <ChevronDownIcon />
          </Select.ScrollDownButton>
        </Select.Content>
      </Select.Portal>
    </Select.Root>
  </div>
}
