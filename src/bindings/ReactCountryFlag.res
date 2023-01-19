module Flag = {
  @module("react-country-flag") @react.component
  external make: (~countryCode: string=?, ~svg: bool=?) => React.element = "default"
}
