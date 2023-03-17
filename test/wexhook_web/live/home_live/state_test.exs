defmodule WexhookWeb.HomeLive.StateTest do
  use ExUnit.Case, async: true

  alias WexhookWeb.HomeLive.State

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
end
