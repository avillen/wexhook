defmodule Wexhook.Request do
  @moduledoc """
  A request entity.
  """

  @type id :: String.t()
  @type method :: String.t()
  @type headers :: [{String.t(), String.t()}]
  @type body :: String.t()
  @type created_at :: DateTime.t()

  @type t :: %__MODULE__{
          id: id,
          method: method,
          headers: headers,
          body: body,
          created_at: created_at
        }

  defstruct ~w(
    id
    method
    headers
    body
    created_at
  )a

  @spec new(id, method, headers, body, created_at) :: t
  def new(id, method, headers, body, created_at) do
    %__MODULE__{
      id: id,
      method: method,
      headers: headers,
      body: body,
      created_at: created_at
    }
  end
end
