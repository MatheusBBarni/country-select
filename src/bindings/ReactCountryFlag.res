module Flag = {
  @module("react-country-flag") @react.component
  external make: (~countryCode: string=?) => React.element = "default"
}
