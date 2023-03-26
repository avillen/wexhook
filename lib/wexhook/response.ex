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
  def new(status \\ 200, headers \\ [], body \\ "{\"status\": \"ok\"}") do
    %__MODULE__{
      status: status,
      headers: headers,
      body: body
    }
  end

  @spec get_status(t) :: status
  def get_status(response) do
    response.status
  end

  @spec get_headers(t) :: headers
  def get_headers(response) do
    response.headers
  end

  @spec get_body(t) :: body
  def get_body(response) do
    response.body
  end
end
