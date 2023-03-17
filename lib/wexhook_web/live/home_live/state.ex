defmodule WexhookWeb.HomeLive.State do
  @type t :: %__MODULE__{
          server_pid: pid() | nil
        }

  defstruct ~w(
    server_pid
  )a

  @spec new() :: t()
  def new do
    %__MODULE__{
      server_pid: nil
    }
  end

  @spec set_server_pid(t(), pid()) :: t()
  def set_server_pid(%__MODULE__{} = state, server_pid) do
    %{state | server_pid: server_pid}
  end
end
