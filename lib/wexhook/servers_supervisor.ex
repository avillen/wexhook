defmodule Wexhook.ServersSupervisor do
  @moduledoc """
  The servers supervisor.
  """

  alias Wexhook.{
    Server,
    ServerRepo
  }

  use DynamicSupervisor

  @spec start_link(Keyword.t()) :: Supervisor.on_start()
  def start_link(init_args \\ []) do
    DynamicSupervisor.start_link(__MODULE__, init_args, [])
  end

  @spec start_server(Server.id()) :: DynamicSupervisor.on_start_child()
  def start_server(id) do
    via = {:via, Registry, {Wexhook.Registry, id}}
    spec = {ServerRepo, id: id, name: via}

    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @spec delete_server(pid()) :: :ok
  def delete_server(pid) do
    do_delete_server(pid)
  end

  @spec delete_servers() :: :ok
  def delete_servers do
    servers = DynamicSupervisor.which_children(__MODULE__)

    Enum.each(servers, fn {_, pid, _, _} ->
      do_delete_server(pid)
    end)

    :ok
  end

  @spec get_server_count() :: non_neg_integer()
  def get_server_count do
    __MODULE__
    |> DynamicSupervisor.which_children()
    |> Enum.count()
  end

  @spec get_server_pid_by_id(Server.id()) :: pid() | nil
  def get_server_pid_by_id(id) do
    case Registry.lookup(Wexhook.Registry, id) do
      [{pid, _}] -> pid
      _ -> nil
    end
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  defp do_delete_server(pid) do
    DynamicSupervisor.terminate_child(__MODULE__, pid)
  end
end
