defmodule WexhookWeb.HomeLive.State do
  @type public_path :: String.t()

  @type t :: %__MODULE__{
          server_pid: pid() | nil,
          public_path: public_path
        }

  defstruct ~w(
    server_pid
    public_path
  )a

  @base_path Application.compile_env!(:wexhook, :base_path)

  @spec new() :: t()
  def new do
    %__MODULE__{
      server_pid: nil,
      public_path: ""
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

  @spec get_server_pid(t()) :: pid() | nil
  def get_server_pid(%__MODULE__{server_pid: server_pid}) do
    server_pid
  end

  @spec get_public_path(t()) :: public_path
  def get_public_path(%__MODULE__{public_path: public_path}) do
    public_path
  end
end
