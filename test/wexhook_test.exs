defmodule WexhookTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureLog

  alias Wexhook

  describe "new_server/1" do
    test "on success" do
      assert {:ok, _} = Wexhook.new_server("public_new_server_on_success")
    end

    test "on error" do
      {:ok, _} = Wexhook.new_server("public_new_server_on_error")

      assert capture_log(fn ->
               assert {:error, _} = Wexhook.new_server("public_new_server_on_error")
             end) =~ "Failed to start server"
    end
  end

  describe "add_request/2" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public_add_request_on_success")

      Wexhook.subscribe_to_server(pid)

      request = %Wexhook.Request{}

      assert :ok == Wexhook.add_request(pid, request)
      assert_receive {:request, ^request}
    end
  end

  describe "get_requests/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public_get_requests_on_success")

      assert [] == Wexhook.get_requests(pid)
    end
  end

  describe "get_request/2" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public_get_request_on_success")

      assert nil == Wexhook.get_request(pid, "id")
    end
  end

  describe "delete_request/2" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public_delete_request_on_success")

      assert [] == Wexhook.delete_request(pid, "id")
    end
  end

  describe "delete_requests/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public_delete_requests_on_success")

      assert [] == Wexhook.delete_requests(pid)
    end
  end

  describe "get_request_count/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public_get_request_count_on_success")

      assert 0 == Wexhook.get_request_count(pid)
    end
  end

  describe "get_server_count/0" do
    test "on success" do
      {:ok, _} = Wexhook.new_server("public_get_server_count_on_success_0")
      {:ok, _} = Wexhook.new_server("public_get_server_count_on_success_1")

      assert Wexhook.get_server_count() > 0
    end
  end

  describe "delete_server/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public_delete_server_on_success")

      assert :ok == Wexhook.delete_server(pid)
    end
  end

  describe "delete_servers/0" do
    test "on success" do
      {:ok, _} = Wexhook.new_server("public_delete_servers_on_success_0")
      {:ok, _} = Wexhook.new_server("public_delete_servers_on_success_1")

      assert :ok = Wexhook.delete_servers()

      assert 0 == Wexhook.get_server_count()
    end
  end

  describe "get_server_by_id/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("get_server_by_id_on_success")

      assert pid == Wexhook.get_server_by_id("get_server_by_id_on_success")
    end
  end

  describe "get_server_id/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("get_server_id_on_success")

      assert "get_server_id_on_success" == Wexhook.get_server_id(pid)
    end
  end

  describe "get_server_or_create/1" do
    test "creates the server if it doesn't exists" do
      assert {:ok, pid} =
               Wexhook.get_server_or_create(
                 "get_server_or_create_if_server_not_exists_on_success"
               )

      assert pid ==
               Wexhook.get_server_by_id("get_server_or_create_if_server_not_exists_on_success")
    end

    test "fetches the server if it exists" do
      {:ok, create_pid} = Wexhook.new_server("get_server_or_create_if_server_exists_on_success")

      assert {:ok, server_pid} =
               Wexhook.get_server_or_create("get_server_or_create_if_server_exists_on_success")

      assert create_pid == server_pid
    end
  end

  describe "subscribe_to_server/2" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public_subscribe_to_server_on_success")

      assert :ok == Wexhook.subscribe_to_server(pid)
    end
  end
end
