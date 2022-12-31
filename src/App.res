%%raw(`import './styles/App.scss'`)

@react.component
let make = () => {
  <div className="app">
    <CountrySelect className="" country=Some("us") onChange={country => Js.log(country)} />
  </div>
}
