defmodule Wexhook.Server.InMemory do
  @moduledoc """
  The in-memory server implementation.
  """

  alias Wexhook.Server

  use GenServer

  @behaviour Wexhook.ServerRepo

  @name __MODULE__

  @impl Wexhook.ServerRepo
  def start_link(opts \\ []) do
    id = Keyword.fetch!(opts, :id)

    GenServer.start_link(__MODULE__, id, opts)
  end

  @impl Wexhook.ServerRepo
  def push_request(pid \\ @name, request) do
    GenServer.cast(pid, {:push_request, request})
  end

  @impl Wexhook.ServerRepo
  def get_requests(pid \\ @name) do
    GenServer.call(pid, :get_requests)
  end

  @impl Wexhook.ServerRepo
  def get_request(pid \\ @name, id) do
    GenServer.call(pid, {:get_request, id})
  end

  @impl Wexhook.ServerRepo
  def delete_request(pid \\ @name, id) do
    GenServer.call(pid, {:delete_request, id})
  end

  @impl Wexhook.ServerRepo
  def delete_requests(pid \\ @name) do
    GenServer.call(pid, :delete_requests)
  end

  @impl Wexhook.ServerRepo
  def get_request_count(pid \\ @name) do
    GenServer.call(pid, :get_request_count)
  end

  @impl Wexhook.ServerRepo
  def get_id(pid \\ @name) do
    GenServer.call(pid, :get_id)
  end

  @impl Wexhook.ServerRepo
  def get_response(pid \\ @name) do
    GenServer.call(pid, :get_response)
  end

  @impl Wexhook.ServerRepo
  def set_response(pid \\ @name, response) do
    GenServer.call(pid, {:set_response, response})
  end

  @impl true
  def init(id) do
    {:ok, Server.new(id)}
  end

  @impl true
  def handle_cast({:push_request, request}, state) do
    {:noreply, Server.add_request(state, request)}
  end

  @impl true
  def handle_call(:get_requests, _from, state) do
    {:reply, Server.get_requests(state), state}
  end

  @impl true
  def handle_call({:get_request, id}, _from, state) do
    {:reply, Server.get_request(state, id), state}
  end

  @impl true
  def handle_call({:delete_request, id}, _from, state) do
    state = Server.delete_request(state, id)

    {:reply, state.requests, state}
  end

  @impl true
  def handle_call(:delete_requests, _from, state) do
    state = Server.delete_requests(state)

    {:reply, state.requests, state}
  end

  @impl true
  def handle_call(:get_request_count, _from, state) do
    {:reply, Server.get_request_count(state), state}
  end

  @impl true
  def handle_call(:get_id, _from, state) do
    {:reply, Server.get_id(state), state}
  end

  @impl true
  def handle_call(:get_response, _from, state) do
    {:reply, Server.get_response(state), state}
  end

  @impl true
  def handle_call({:set_response, response}, _from, state) do
    state = Server.set_response(state, response)

    {:reply, state.response, state}
  end
end
