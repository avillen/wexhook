defmodule Wexhook.Request do
  @type id :: String.t()
  @type method :: String.t()
  @type headers :: [{String.t(), String.t()}]
  @type body :: String.t()

  @type t :: %__MODULE__{
          id: id,
          method: method,
          headers: headers,
          body: body
        }

  defstruct ~w(
    id
    method
    headers
    body
  )a

  @spec new(id, method, headers, body) :: t
  def new(id, method, headers, body) do
    %__MODULE__{
      id: id,
      method: method,
      headers: headers,
      body: body
    }
  end
end
