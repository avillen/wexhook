defmodule WexhookWeb.HomeLive do
  use Phoenix.LiveView

  alias Wexhook.Components.HookCard
  alias __MODULE__.State

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send(self(), :create_server, [])
    end

    {:ok, assign(socket, :state, State.new())}
  end

  # Init server handler
  def handle_info(:create_server, socket) do
    {:ok, server_pid} = Wexhook.new_server()
    public_path = Wexhook.get_server_public_path(server_pid)

    state =
      socket
      |> WexhookWeb.get_state()
      |> State.set_server_pid(server_pid)
      |> State.set_public_path(public_path)

    state
    |> State.get_server_pid()
    |> Wexhook.subscribe_to_server()

    {:noreply, assign(socket, :state, state)}
  end

  # PubSub :request handler
  def handle_info({:request, request}, socket) do
    state =
      socket
      |> WexhookWeb.get_state()
      |> State.add_request(request)

    socket =
      socket
      |> assign(:state, state)
      |> push_event("request_received", %{})

    {:noreply, socket}
  end
end
