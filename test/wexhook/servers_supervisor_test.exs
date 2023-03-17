defmodule Wexhook.ServersSupervisorTest do
  use ExUnit.Case, async: true

  alias Wexhook.ServersSupervisor

  test "start_server/0" do
    assert {:ok, _} = ServersSupervisor.start_server("public")
  end

  test "delete_server/1" do
    {:ok, pid} = ServersSupervisor.start_server("public")

    assert :ok = ServersSupervisor.delete_server(pid)
  end

  test "delete_servers/0" do
    {:ok, _} = ServersSupervisor.start_server("public")
    {:ok, _} = ServersSupervisor.start_server("public")

    assert :ok = ServersSupervisor.delete_servers()
  end

  test "get_server_count/0" do
    {:ok, _} = ServersSupervisor.start_server("public")
    {:ok, _} = ServersSupervisor.start_server("public")

    server_count = ServersSupervisor.get_server_count()

    assert server_count > 0
  end
end
