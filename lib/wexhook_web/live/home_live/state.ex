defmodule WexhookWeb.HomeLive.State do
  @moduledoc """
  The state of the home live view.
  """

  alias Wexhook.{Request, Response}

  @type public_path :: String.t()
  @type share_url :: String.t()
  @type request :: Request.t()
  @type response :: Response.t()

  @type t :: %__MODULE__{
          public_path: public_path,
          requests: [request],
          response: response,
          server_pid: pid() | nil,
          share_url: share_url
        }

  defstruct ~w(
    public_path
    requests
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
      requests: [],
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

  @spec add_request(t(), request) :: t()
  def add_request(%__MODULE__{} = state, request) do
    %{state | requests: [request | state.requests]}
  end

  @spec set_share_url(t(), public_path, URI.t()) :: t()
  def set_share_url(%__MODULE__{} = state, public_path, host_uri) do
    %{state | share_url: URI.to_string(host_uri) <> @share_base_path <> public_path}
  end

  @spec set_requests(t(), [request]) :: t()
  def set_requests(%__MODULE__{} = state, requests) do
    %{state | requests: requests}
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

  @spec get_share_url(t()) :: share_url
  def get_share_url(%__MODULE__{share_url: share_url}) do
    share_url
  end

  @spec get_request(t(), String.t()) :: request | nil
  def get_request(%__MODULE__{requests: requests}, id) do
    Enum.find(requests, &(&1.id == id))
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
