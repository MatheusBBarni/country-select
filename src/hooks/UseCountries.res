let apiUrl = "https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json"

type country = {
  label: string,
  value: string,
}

type coutries =
  | Data(array<country>)
  | Error
  | Loading
  | Empty

module GetCountries = Axios.MakeAxios({
  type t = array<country>
})

let useCoutries = () => {
  let (status, setStatus) = React.useState(_ => Loading)

  React.useEffect0(() => {
    open Promise

    GetCountries.get(apiUrl)
    ->then(response => {
      let result = response.data
      switch result {
      | [] => setStatus(_ => Empty)
      | _ => setStatus(_ => Data(result))
      }
      resolve()
    })
    ->catch(_ => {
      setStatus(_ => Error)
      resolve()
    })
    ->ignore

    None
  })

  status
}
