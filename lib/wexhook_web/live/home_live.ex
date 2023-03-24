defmodule WexhookWeb.HomeLive do
  @moduledoc """
  The home live view.
  """

  use Phoenix.LiveView
  alias Phoenix.LiveView.JS

  alias WexhookWeb.Components.HookCard

  alias __MODULE__.State

  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Process.send(self(), {:fetch_server, id}, [])
    end

    {:ok, assign(socket, :state, State.new())}
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send(self(), :create_server, [])
    end

    {:ok, assign(socket, :state, State.new())}
  end

  # Create server handler
  def handle_info(:create_server, socket) do
    {:ok, server_pid} = Wexhook.new_server()
    id = Wexhook.get_server_id(server_pid)

    state =
      socket
      |> WexhookWeb.get_state()
      |> State.set_server_pid(server_pid)
      |> State.set_public_path(id)
      |> State.set_share_url(id)

    Wexhook.subscribe_to_server(server_pid)

    {:noreply, assign(socket, :state, state)}
  end

  # Fetch server handler
  def handle_info({:fetch_server, id}, socket) do
    {:ok, pid} = Wexhook.get_server_or_create(id)

    state =
      socket
      |> WexhookWeb.get_state()
      |> State.set_server_pid(pid)
      |> State.set_public_path(id)
      |> State.set_share_url(id)
      |> State.set_requests(Wexhook.get_requests(pid))

    Wexhook.subscribe_to_server(pid)

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
