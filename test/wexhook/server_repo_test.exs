defmodule Wexhook.ServerRepoTest do
  use ExUnit.Case, async: true

  alias Wexhook.Response
  alias Wexhook.ServerRepo
  alias Wexhook.Support.Strings

  @kill_after 10_000

  test "start_link/1" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    assert {:ok, _} = ServerRepo.start_link(opts)
  end

  test "push_request/2" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    assert :ok = ServerRepo.push_request(pid, %{id: "id"})
  end

  test "get_requests/1" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    assert [] = ServerRepo.get_requests(pid)
  end

  test "get_request/2" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    assert nil == ServerRepo.get_request(pid, "id")
  end

  test "delete_request/2" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    assert [] = ServerRepo.delete_request(pid, "id")
  end

  test "delete_requests/1" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    assert [] = ServerRepo.delete_requests(pid)
  end

  test "get_request_count/1" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    assert 0 = ServerRepo.get_request_count(pid)
  end

  test "get_id/1" do
    id = Strings.random_string()
    opts = [id: id, kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    assert id == ServerRepo.get_id(pid)
  end

  test "set_response/2" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    response = Response.new(200, %{}, "body")
    assert response == ServerRepo.set_response(pid, response)
  end

  test "get_response/1" do
    opts = [id: Strings.random_string(), kill_after: @kill_after]
    {:ok, pid} = ServerRepo.start_link(opts)
    response = Response.new(200, %{}, "body")
    ServerRepo.set_response(pid, response)
    assert response == ServerRepo.get_response(pid)
  end
end
