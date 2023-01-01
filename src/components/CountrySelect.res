%%raw(`import '../styles/CountrySelect.scss'`)

open Renderer
open Radix
open RadixIcons

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

  let make = React.memo(make)
}

@react.component
let make = (~className: string, ~country: option<string>, ~onChange: string => unit) => {
  let (countries, loading, error) = Countries.useCountries()
  let (search, setSearch) = React.useState(_ => "")

  let value = React.useMemo4(() => {
    switch (loading, error, countries) {
    | (true, false, Empty) => None
    | (false, true, Empty) => None
    | _ => country
    }
  }, (loading, error, countries, country))

  <div className={`country-select ${className}`}>
    <Select.Root value onClick={_ => Js.log("123")} onValueChange=onChange>
      <Select.Trigger className="country-select__trigger">
        <Select.Value placeholder="Select a country">
          {switch (value, countries) {
          | (None, _) => ""
          | (Some(countryCode), Data(countries)) =>
            switch countries->Js.Array2.find(country => country.value == countryCode) {
            | None => ""
            | Some(country) => country.label
            }
          | _ => ""
          }->s}
        </Select.Value>
        <Select.Icon className="country-select__icon">
          <TriangleDownIcon width=20 height=20 />
        </Select.Icon>
      </Select.Trigger>
      <Select.Portal>
        <Select.Content className="country-select__content">
          <SearchInput value=search onChange={value => setSearch(_ => value)} />
          <Select.ScrollUpButton className="country-select__scroll-button">
            <ChevronUpIcon />
          </Select.ScrollUpButton>
          <Select.Viewport className="country-select__viewport">
            {switch countries {
            | Empty => <SelectItem value="" label="No countries" />
            | Data(countries) =>
              countries
              ->Js.Array2.filter(country =>
                search
                ->Js.String.toLowerCase
                ->Js.String.includes(country.label->Js.String.toLowerCase)
              )
              ->map(country => {
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

let make = React.memo(make)
