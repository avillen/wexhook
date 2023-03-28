defmodule WexhookWeb.HomeLive.State do
  @moduledoc """
  The state of the home live view.
  """

  alias Wexhook.Response

  @type public_path :: String.t()
  @type share_url :: String.t()
  @type response :: Response.t()

  @type t :: %__MODULE__{
          public_path: public_path,
          response: response,
          server_pid: pid() | nil,
          share_url: share_url
        }

  defstruct ~w(
    public_path
    response
    server_pid
    share_url
  )a

  @hook_base_path Application.compile_env!(:wexhook, :hook_base_path)
  @share_base_path Application.compile_env!(:wexhook, :share_base_path)

  @spec new() :: t()
  def new do
    %__MODULE__{
      server_pid: nil,
      public_path: "",
      share_url: "",
      response: Response.new()
    }
  end

  @spec set_server_pid(t(), pid()) :: t()
  def set_server_pid(%__MODULE__{} = state, server_pid) do
    %{state | server_pid: server_pid}
  end

  @spec set_public_path(t(), public_path, URI.t()) :: t()
  def set_public_path(%__MODULE__{} = state, public_path, host_uri) do
    %{state | public_path: URI.to_string(host_uri) <> @hook_base_path <> public_path}
  end

  @spec set_share_url(t(), public_path, URI.t()) :: t()
  def set_share_url(%__MODULE__{} = state, public_path, host_uri) do
    %{state | share_url: URI.to_string(host_uri) <> @share_base_path <> public_path}
  end

  @spec get_server_pid(t()) :: pid() | nil
  def get_server_pid(%__MODULE__{server_pid: server_pid}) do
    server_pid
  end

  @spec get_public_path(t()) :: public_path
  def get_public_path(%__MODULE__{public_path: public_path}) do
    public_path
  end

  @spec get_share_url(t()) :: share_url
  def get_share_url(%__MODULE__{share_url: share_url}) do
    share_url
  end

  @spec set_response(t(), response) :: t()
  def set_response(%__MODULE__{} = state, response) do
    %{state | response: response}
  end

  @spec get_response(t()) :: response
  def get_response(%__MODULE__{response: response}) do
    response
  end
end
