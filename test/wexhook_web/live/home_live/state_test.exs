defmodule WexhookWeb.HomeLive.StateTest do
  use ExUnit.Case, async: true

  alias WexhookWeb.HomeLive.State

  @base_path Application.compile_env!(:wexhook, :base_path)

  describe "new/0" do
    test "returns a new state" do
      assert %State{} = State.new()
    end
  end

  describe "set_server_pid/2" do
    test "sets the server pid" do
      state = %State{}
      pid = self()

      assert %State{server_pid: ^pid} = State.set_server_pid(state, pid)
    end
  end

  describe "set_public_path/2" do
    test "sets the public path" do
      state = %State{}
      path = "/path/to/public"
      url = @base_path <> path

      assert %State{public_path: ^url} = State.set_public_path(state, path)
    end
  end

  describe "get_server_pid/1" do
    test "returns the server pid" do
      pid = self()
      state = %State{server_pid: pid}

      assert ^pid = State.get_server_pid(state)
    end
  end

  describe "get_public_path/1" do
    test "returns the public path" do
      path = "/path/to/public"
      url = @base_path <> path
      state = %State{public_path: url}

      assert ^url = State.get_public_path(state)
    end
  end
end
