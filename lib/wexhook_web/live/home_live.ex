defmodule WexhookWeb.HomeLive do
  use Phoenix.LiveView

  alias __MODULE__.State

  def mount(_params, _session, socket) do
    if connected?(socket) do
      create_server()
    end

    {:ok, assign(socket, :state, State.new())}
  end

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

  defp create_server do
    Process.send(self(), :create_server, [])
  end
end
