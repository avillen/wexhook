defmodule WexhookWeb.HomeLive.State do
  alias Wexhook.Request

  @type public_path :: String.t()
  @type request :: Request.t()

  @type t :: %__MODULE__{
          server_pid: pid() | nil,
          public_path: public_path,
          requests: [request]
        }

  defstruct ~w(
    server_pid
    public_path
    requests
  )a

  @base_path Application.compile_env!(:wexhook, :base_path)

  @spec new() :: t()
  def new do
    %__MODULE__{
      server_pid: nil,
      public_path: "",
      requests: []
    }
  end

  @spec set_server_pid(t(), pid()) :: t()
  def set_server_pid(%__MODULE__{} = state, server_pid) do
    %{state | server_pid: server_pid}
  end

  @spec set_public_path(t(), public_path) :: t()
  def set_public_path(%__MODULE__{} = state, public_path) do
    %{state | public_path: @base_path <> public_path}
  end

  @spec add_request(t(), request) :: t()
  def add_request(%__MODULE__{} = state, request) do
    %{state | requests: [request | state.requests]}
  end

  @spec get_server_pid(t()) :: pid() | nil
  def get_server_pid(%__MODULE__{server_pid: server_pid}) do
    server_pid
  end

  @spec get_public_path(t()) :: public_path
  def get_public_path(%__MODULE__{public_path: public_path}) do
    public_path
  end

  @spec get_requests(t()) :: [request]
  def get_requests(%__MODULE__{requests: requests}) do
    requests
  end
end
