defmodule Wexhook.Server.InMemoryTest do
  use ExUnit.Case, async: true

  alias Wexhook.Request
  alias Wexhook.Server.InMemory, as: Server

  @kill_after 10_000

  describe "start_link/1" do
    test "success" do
      {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)
      assert is_pid(pid)
    end
  end

  test "push_request/1" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())

    assert :ok = Server.push_request(pid, request)
  end

  test "get_requests/0" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert [^request] = Server.get_requests(pid)
  end

  test "get_request/1" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert ^request = Server.get_request(pid, "id")
  end

  test "delete_request/1" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert [] = Server.delete_request(pid, "id")
  end

  test "delete_requests/0" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert [] = Server.delete_requests(pid)
    assert [] = Server.get_requests(pid)
  end

  test "get_request_count/0" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    request = Request.new("id", :get, %{}, "body", DateTime.utc_now())
    Server.push_request(pid, request)

    assert 1 = Server.get_request_count(pid)
  end

  test "get_id/0" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    assert "public" = Server.get_id(pid)
  end

  test "set_response/1" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    assert %{body: "", headers: [], status: 200} ==
             Server.set_response(pid, %{status: 200, headers: [], body: ""})
  end

  test "get_response/0" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: @kill_after)

    assert %{status: 200, headers: [], body: ~s({"status":"ok"})} = Server.get_response(pid)
  end

  test "timeout handler" do
    {:ok, pid} = Server.start_link(id: "public", kill_after: 100)

    Process.sleep(200)

    refute Process.alive?(pid)
  end
end
