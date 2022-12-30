type axiosResponse<'a> = {
  status: int,
  statusText: string,
  data: 'a,
}

module type Config = {
  type t
}

module MakeAxios = (M: Config) => {
  @module("axios") external get: string => Promise.t<axiosResponse<M.t>> = "get"
}
