defmodule Wexhook.Response do
  @moduledoc """
  A response to a request.
  """

  @type status :: non_neg_integer()
  @type headers :: [{String.t(), String.t()}]
  @type body :: String.t()

  @type t :: %__MODULE__{
          status: status,
          headers: headers,
          body: body
        }

  defstruct ~w(
    status
    headers
    body
  )a

  @spec new(status, headers, body) :: t()
  def new(status \\ 200, headers \\ [], body \\ "") do
    %__MODULE__{
      status: status,
      headers: headers,
      body: body
    }
  end
end
