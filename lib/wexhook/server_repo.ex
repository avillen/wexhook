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
end
