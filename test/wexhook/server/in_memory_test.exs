defmodule Wexhook.Server.InMemoryTest do
  use ExUnit.Case, async: true

  alias Wexhook.Request
  alias Wexhook.Server.InMemory, as: Server

  describe "start_link/1" do
    test "success" do
      {:ok, pid} = Server.start_link(public_path: "public")
      assert is_pid(pid)
    end
  end

  test "push_request/1" do
    {:ok, pid} = Server.start_link(public_path: "public")

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())

    assert :ok = Server.push_request(pid, request)
  end

  test "get_requests/0" do
    {:ok, pid} = Server.start_link(public_path: "public")

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert [^request] = Server.get_requests(pid)
  end

  test "get_request/1" do
    {:ok, pid} = Server.start_link(public_path: "public")

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert ^request = Server.get_request(pid, "id")
  end

  test "delete_request/1" do
    {:ok, pid} = Server.start_link(public_path: "public")

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert [] = Server.delete_request(pid, "id")
  end

  test "delete_requests/0" do
    {:ok, pid} = Server.start_link(public_path: "public")

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert [] = Server.delete_requests(pid)
    assert [] = Server.get_requests(pid)
  end

  test "get_request_count/0" do
    {:ok, pid} = Server.start_link(public_path: "public")

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert 1 = Server.get_request_count(pid)
  end

  test "get_public_path/0" do
    {:ok, pid} = Server.start_link(public_path: "public")

    assert "public" = Server.get_public_path(pid)
  end
end
