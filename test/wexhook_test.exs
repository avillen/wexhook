defmodule WexhookTest do
  use ExUnit.Case, async: true

  alias Wexhook

  describe "new_server/1" do
    test "on success" do
      assert {:ok, _} = Wexhook.new_server("public")
    end
  end

  describe "add_request/2" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public")

      assert :ok == Wexhook.add_request(pid, %Wexhook.Request{})
    end
  end

  describe "get_requests/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public")

      assert [] == Wexhook.get_requests(pid)
    end
  end

  describe "get_request/2" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public")

      assert nil == Wexhook.get_request(pid, "id")
    end
  end

  describe "delete_request/2" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public")

      assert [] == Wexhook.delete_request(pid, "id")
    end
  end

  describe "delete_requests/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public")

      assert [] == Wexhook.delete_requests(pid)
    end
  end

  describe "get_request_count/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public")

      assert 0 == Wexhook.get_request_count(pid)
    end
  end

  describe "get_server_count/0" do
    test "on success" do
      {:ok, _} = Wexhook.new_server("public")
      {:ok, _} = Wexhook.new_server("public")

      assert Wexhook.get_server_count() > 0
    end
  end

  describe "delete_server/1" do
    test "on success" do
      {:ok, pid} = Wexhook.new_server("public")

      assert :ok == Wexhook.delete_server(pid)
    end
  end

  describe "delete_servers/0" do
    test "on success" do
      {:ok, _} = Wexhook.new_server("public")
      {:ok, _} = Wexhook.new_server("public")

      assert :ok = Wexhook.delete_servers()

      assert 0 == Wexhook.get_server_count()
    end
  end
end
