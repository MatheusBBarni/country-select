%%raw(`import '../styles/CountrySelect.scss'`)

@react.component
let make = (~className: string, ~country: option<string>, ~onChange: string => unit) => {
  let coutriesStatus = UseCountries.useCoutries()

  Js.log(coutriesStatus)

  <div className="container">
    <span className="fi fi-br" />
    <h1> {"Test"->React.string} </h1>
  </div>
}
