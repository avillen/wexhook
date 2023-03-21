defmodule Wexhook.Server do
  @moduledoc """
  The behaviour for a server.
  """

  alias __MODULE__.State

  @adapter Application.compile_env!(:wexhook, __MODULE__)[:adapter]

  @name __MODULE__

  @callback start_link(Keyword.t()) :: GenServer.on_start()
  @callback push_request(pid, any()) :: :ok
  @callback get_requests(pid) :: State.requests()
  @callback get_request(pid, Request.id()) :: Request.t()
  @callback delete_request(pid, Request.id()) :: State.requests()
  @callback delete_requests(pid) :: State.requests()
  @callback get_request_count(pid) :: non_neg_integer()
  @callback get_id(pid) :: State.id()

  @spec start_link(Keyword.t()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    @adapter.start_link(opts)
  end

  @spec push_request(pid, any()) :: :ok
  def push_request(pid \\ @name, request) do
    @adapter.push_request(pid, request)
  end

  @spec get_requests(pid) :: State.requests()
  def get_requests(pid \\ @name) do
    @adapter.get_requests(pid)
  end

  @spec get_request(pid, Request.id()) :: Request.t()
  def get_request(pid \\ @name, id) do
    @adapter.get_request(pid, id)
  end

  @spec delete_request(pid, Request.id()) :: State.requests()
  def delete_request(pid \\ @name, id) do
    @adapter.delete_request(pid, id)
  end

  @spec delete_requests(pid) :: State.requests()
  def delete_requests(pid \\ @name) do
    @adapter.delete_requests(pid)
  end

  @spec get_request_count(pid) :: non_neg_integer()
  def get_request_count(pid \\ @name) do
    @adapter.get_request_count(pid)
  end

  @spec get_id(pid) :: State.id()
  def get_id(pid \\ @name) do
    @adapter.get_id(pid)
  end
end
