defmodule WexhookWeb.HomeLive do
  @moduledoc """
  The home live view.
  """

  use Phoenix.LiveView

  alias WexhookWeb.Components.{
    DarkmodeToggle,
    HookCard
  }

  alias __MODULE__.{
    Parser,
    State
  }

  alias Phoenix.LiveView.JS

  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket) do
      Process.send(self(), {:fetch_server, id}, [])
    end

    socket = update_socket(socket, State.new(), [])

    {:ok, socket, temporary_assigns: [requests: []]}
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send(self(), :create_server, [])
    end

    socket = update_socket(socket, State.new(), [])

    {:ok, socket, temporary_assigns: [requests: []]}
  end

  # Create server handler
  def handle_info(:create_server, socket) do
    {:ok, server_pid} = Wexhook.new_server()
    id = Wexhook.get_server_id(server_pid)

    state = load_state(socket, server_pid, id)

    Wexhook.subscribe_to_server(server_pid)

    {:noreply, assign(socket, :state, state)}
  end

  # Fetch server handler
  def handle_info({:fetch_server, id}, socket) do
    server_pid = Wexhook.get_server_or_create(id)

    state = load_state(socket, server_pid, id)

    Wexhook.subscribe_to_server(server_pid)

    socket = update_socket(socket, state, Wexhook.get_requests(server_pid))

    {:noreply, socket}
  end

  # PubSub :request handler
  def handle_info({:request, request}, socket) do
    state = WexhookWeb.get_state(socket)

    socket =
      socket
      |> update_socket(state, [request])
      |> push_event("request_received", %{})

    {:noreply, socket}
  end

  def handle_event(
        "update_response",
        %{"http-code" => http_code, "response-body" => body},
        socket
      ) do
    status = Parser.parse_response_http_code(http_code)
    body = Parser.parse_response_body(body)
    response = Wexhook.Response.new(status, [], body)

    socket
    |> WexhookWeb.get_state()
    |> State.get_server_pid()
    |> Wexhook.set_server_response(response)

    state =
      socket
      |> WexhookWeb.get_state()
      |> State.set_response(response)

    {:noreply, assign(socket, :state, state)}
  end

  defp update_socket(socket, state, requests) do
    socket
    |> assign(:requests, requests)
    |> assign(:state, state)
  end

  defp load_state(socket, server_pid, id) do
    socket
    |> WexhookWeb.get_state()
    |> State.set_server_pid(server_pid)
    |> State.set_public_path(id, WexhookWeb.get_host_uri(socket))
    |> State.set_share_url(id, WexhookWeb.get_host_uri(socket))
    |> State.set_response(Wexhook.get_server_response(server_pid))
  end
end
