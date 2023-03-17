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

    state =
      socket
      |> WexhookWeb.get_state()
      |> State.set_server_pid(server_pid)

    {:noreply, assign(socket, :state, state)}
  end

  defp create_server do
    Process.send(self(), :create_server, [])
  end
end
