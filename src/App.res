@react.component
let make = () => {
  <div className="App">
    <CountrySelect className="" country=None onChange={country => Js.log(country)} />
  </div>
}
