%%raw(`import '../styles/CountrySelect.scss'`)

open Renderer
open Radix
open RadixIcons
open ReactCountryFlag

let randonCountryNumber = () => {
  let firstPart = Js.Math.random_int(1, 500)->Js.Int.toPrecision
  let secondPart = Js.Math.random_int(0, 9)->Js.Int.toPrecision
  `${firstPart}.${secondPart}k`
}

module SelectItem = {
  @react.component
  let make = (~value: string, ~label: string) => {
    <Select.Item className="country-select__item" value>
      <Select.ItemText asChild=true>
        <div className="country-select__item__wrapper">
          <div className="country-select__item__wrapper__texts">
            <Flag countryCode=value />
            <span className="country-select__item__text"> {label->React.string} </span>
          </div>
          <span className="country-select__item__number"> {randonCountryNumber()->s} </span>
        </div>
      </Select.ItemText>
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

  let selectValue = switch (value, countries) {
  | (None, _) => ""
  | (Some(countryCode), Data(countries)) =>
    switch countries->Js.Array2.find(country => country.value == countryCode) {
    | None => ""
    | Some(country) => country.label
    }
  | _ => ""
  }

  <div className={`country-select ${className}`}>
    <Select.Root
      value
      onValueChange={selectedCountry => {
        onChange(selectedCountry)
        setSearch(_ => "")
      }}>
      <Select.Trigger className="country-select__trigger">
        <Select.Value placeholder="Select a country">
          {switch (selectValue, country) {
          | (_, Some(country)) =>
            <div>
              <Flag countryCode=country />
              {selectValue->s}
            </div>

          | ("", None) => selectValue->s
          }}
        </Select.Value>
        <Select.Icon className="country-select__icon">
          <TriangleDownIcon width=20 height=20 />
        </Select.Icon>
      </Select.Trigger>
      <Select.Portal>
        <Select.Content className="country-select__content">
          <div>
            <SearchInput value=search onChange={value => setSearch(_ => value)} />
          </div>
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
