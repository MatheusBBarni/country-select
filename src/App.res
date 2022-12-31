%%raw(`import './styles/App.scss'`)

@react.component
let make = () => {
  let (selectedCountry, setSelectedCountry) = React.useState(_ => Some("us"))

  <div className="app">
    <CountrySelect
      className=""
      country=selectedCountry
      onChange={country => setSelectedCountry(_ => Some(country))}
    />
  </div>
}
