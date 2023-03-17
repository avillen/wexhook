defmodule Wexhook.ServersSupervisor do
  alias Wexhook.Server.InMemory, as: Server

  use DynamicSupervisor

  def start_link(init_args \\ []) do
    DynamicSupervisor.start_link(__MODULE__, init_args, [])
  end

  def start_server(public_path) do
    spec = {Server, public_path: public_path}

    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def delete_server(pid) do
    do_delete_server(pid)
  end

  def delete_servers do
    servers = DynamicSupervisor.which_children(__MODULE__)

    Enum.each(servers, fn {_, pid, _, _} ->
      do_delete_server(pid)
    end)

    :ok
  end

  def get_server_count do
    __MODULE__
    |> DynamicSupervisor.which_children()
    |> Enum.count()
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  defp do_delete_server(pid) do
    DynamicSupervisor.terminate_child(__MODULE__, pid)
  end
end
