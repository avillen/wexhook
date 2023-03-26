defmodule Wexhook.ServerRepo do
  @moduledoc """
  The behaviour for a server.
  """

  alias Wexhook.{Request, Server}

  @adapter Application.compile_env!(:wexhook, __MODULE__)[:adapter]

  @name __MODULE__

  @type server_pid :: pid() | module()

  @callback start_link(Keyword.t()) :: GenServer.on_start()
  @callback push_request(server_pid, any()) :: :ok
  @callback get_requests(server_pid) :: [Server.request()]
  @callback get_request(server_pid, Request.id()) :: Request.t()
  @callback delete_request(server_pid, Request.id()) :: [Server.request()]
  @callback delete_requests(server_pid) :: [Server.request()]
  @callback get_request_count(server_pid) :: non_neg_integer()
  @callback get_id(server_pid) :: Server.id()
  @callback get_response(server_pid) :: Server.response()
  @callback set_response(server_pid, Server.response()) :: :ok

  @spec child_spec(Keyword.t()) :: Supervisor.child_spec()
  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  @spec start_link(Keyword.t()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    @adapter.start_link(opts)
  end

  @spec push_request(server_pid, Server.request()) :: :ok
  def push_request(server_pid \\ @name, request) do
    @adapter.push_request(server_pid, request)
  end

  @spec get_requests(server_pid) :: [Server.request()]
  def get_requests(server_pid \\ @name) do
    @adapter.get_requests(server_pid)
  end

  @spec get_request(server_pid, Request.id()) :: Request.t()
  def get_request(server_pid \\ @name, id) do
    @adapter.get_request(server_pid, id)
  end

  @spec delete_request(server_pid, Request.id()) :: [Server.request()]
  def delete_request(server_pid \\ @name, id) do
    @adapter.delete_request(server_pid, id)
  end

  @spec delete_requests(server_pid) :: [Server.request()]
  def delete_requests(server_pid \\ @name) do
    @adapter.delete_requests(server_pid)
  end

  @spec get_request_count(server_pid) :: non_neg_integer()
  def get_request_count(server_pid \\ @name) do
    @adapter.get_request_count(server_pid)
  end

  @spec get_id(server_pid) :: Server.id()
  def get_id(server_pid \\ @name) do
    @adapter.get_id(server_pid)
  end

  @spec get_response(server_pid) :: Server.response()
  def get_response(server_pid \\ @name) do
    @adapter.get_response(server_pid)
  end

  @spec set_response(server_pid, Server.response()) :: Server.response()
  def set_response(server_pid \\ @name, response) do
    @adapter.set_response(server_pid, response)
  end
end
