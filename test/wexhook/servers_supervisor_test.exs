defmodule Wexhook.ServersSupervisorTest do
  use ExUnit.Case, async: true

  alias Wexhook.ServersSupervisor

  test "start_link/1" do
    assert {:ok, _} = ServersSupervisor.start_link()
  end

  test "start_server/0" do
    assert {:ok, _} = ServersSupervisor.start_server("public_start_server")
  end

  test "delete_server/1" do
    {:ok, pid} = ServersSupervisor.start_server("public_delete_server")

    assert :ok = ServersSupervisor.delete_server(pid)
  end

  test "delete_servers/0" do
    {:ok, _} = ServersSupervisor.start_server("public_delete_servers_0")
    {:ok, _} = ServersSupervisor.start_server("public_delete_servers_1")

    assert :ok = ServersSupervisor.delete_servers()
  end

  test "get_server_count/0" do
    {:ok, _} = ServersSupervisor.start_server("public_get_server_count_0")
    {:ok, _} = ServersSupervisor.start_server("public_get_server_count_1")

    server_count = ServersSupervisor.get_server_count()

    assert server_count > 0
  end

  test "get_server_pid_by_id/1" do
    {:ok, pid} = ServersSupervisor.start_server("public_get_server_pid_by_id")

    assert pid == ServersSupervisor.get_server_pid_by_id("public_get_server_pid_by_id")
  end
end
