defmodule Wexhook.Server do
  alias __MODULE__.State

  use GenServer

  @name __MODULE__

  def start_link(opts \\ []) do
    public_path = Keyword.fetch!(opts, :public_path)

    GenServer.start_link(__MODULE__, public_path, opts)
  end

  @spec push_request(pid, any()) :: :ok
  def push_request(pid \\ @name, request) do
    GenServer.cast(pid, {:push_request, request})
  end

  @spec get_requests(pid) :: State.requests()
  def get_requests(pid \\ @name) do
    GenServer.call(pid, :get_requests)
  end

  @spec get_request(pid, Request.id()) :: Request.t()
  def get_request(pid \\ @name, id) do
    GenServer.call(pid, {:get_request, id})
  end

  @spec delete_request(pid, Request.id()) :: State.requests()
  def delete_request(pid \\ @name, id) do
    GenServer.call(pid, {:delete_request, id})
  end

  @spec delete_requests(pid) :: State.requests()
  def delete_requests(pid \\ @name) do
    GenServer.call(pid, :delete_requests)
  end

  @spec get_request_count(pid) :: non_neg_integer()
  def get_request_count(pid \\ @name) do
    GenServer.call(pid, :get_request_count)
  end

  @spec get_public_path(pid) :: State.public_path()
  def get_public_path(pid \\ @name) do
    GenServer.call(pid, :get_public_path)
  end

  @impl true
  def init(public_path) do
    {:ok, State.new(public_path)}
  end

  @impl true
  def handle_cast({:push_request, request}, state) do
    {:noreply, State.add_request(state, request)}
  end

  @impl true
  def handle_call(:get_requests, _from, state) do
    {:reply, State.get_requests(state), state}
  end

  @impl true
  def handle_call({:get_request, id}, _from, state) do
    {:reply, State.get_request(state, id), state}
  end

  @impl true
  def handle_call({:delete_request, id}, _from, state) do
    state = State.delete_request(state, id)

    {:reply, state.requests, state}
  end

  @impl true
  def handle_call(:delete_requests, _from, state) do
    state = State.delete_requests(state)

    {:reply, state.requests, state}
  end

  @impl true
  def handle_call(:get_request_count, _from, state) do
    {:reply, State.get_request_count(state), state}
  end

  @impl true
  def handle_call(:get_public_path, _from, state) do
    {:reply, State.get_public_path(state), state}
  end
end
