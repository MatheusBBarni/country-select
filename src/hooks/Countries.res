open Models

let apiUrl = "https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json"

type coutries =
  | Data(array<country>)
  | Empty

module GetCountries = Axios.MakeAxios({
  type t = array<country>
})

let useCountries = () => {
  let (countries, setCountries) = React.useState(_ => Empty)
  let (loading, setLoading) = React.useState(_ => true)
  let (error, setError) = React.useState(_ => false)

  React.useEffect0(() => {
    open Promise

    GetCountries.get(apiUrl)
    ->then(response => {
      setLoading(_ => false)

      let result = response.data
      switch result {
      | [] => setCountries(_ => Empty)
      | _ => setCountries(_ => Data(result))
      }
      resolve()
    })
    ->catch(_ => {
      setError(_ => true)
      setLoading(_ => false)
      resolve()
    })
    ->ignore

    None
  })

  (countries, loading, error)
}
