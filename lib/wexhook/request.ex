defmodule Wexhook.Request do
  @type id :: String.t()
  @type url :: String.t()
  @type method ::
          :get
          | :post
          | :put
          | :patch
          | :delete
          | :head
          | :options
          | :trace

  @type headers :: %{String.t() => String.t()}
  @type body :: String.t()

  @type t :: %__MODULE__{
          id: id,
          url: url,
          method: method,
          headers: headers,
          body: body
        }

  defstruct ~w(
    id
    url
    method
    headers
    body
  )a

  @spec new(id, url, method, headers, body) :: t
  def new(id, url, method, headers, body) do
    %__MODULE__{
      id: id,
      url: url,
      method: method,
      headers: headers,
      body: body
    }
  end
end
