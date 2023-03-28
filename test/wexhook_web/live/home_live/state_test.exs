defmodule WexhookWeb.HomeLive.StateTest do
  use ExUnit.Case, async: true

  alias WexhookWeb.HomeLive.State

  @hook_base_path Application.compile_env!(:wexhook, :hook_base_path)
  @share_base_path Application.compile_env!(:wexhook, :share_base_path)

  describe "new/0" do
    test "returns a new state" do
      assert %State{} = State.new()
    end
  end

  describe "set_server_pid/2" do
    test "sets the server pid" do
      state = State.new()
      pid = self()

      assert %State{server_pid: ^pid} = State.set_server_pid(state, pid)
    end
  end

  describe "set_public_path/2" do
    test "sets the public path" do
      state = State.new()
      path = "/path/to/public"
      uri = URI.parse("http://google.com")
      url = URI.to_string(uri) <> @hook_base_path <> path

      assert %State{public_path: ^url} = State.set_public_path(state, path, uri)
    end
  end

  describe "set_share_url/1" do
    test "sets the share url" do
      state = State.new()
      path = "/path/to/public"
      uri = URI.parse("http://google.com")
      url = URI.to_string(uri) <> @share_base_path <> path

      assert %State{share_url: ^url} = State.set_share_url(state, path, uri)
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
      url = @hook_base_path <> path
      state = %State{public_path: url}

      assert ^url = State.get_public_path(state)
    end
  end

  describe "get_share_url/1" do
    test "returns the share url" do
      url = @share_base_path
      state = %State{share_url: url}

      assert ^url = State.get_share_url(state)
    end
  end

  describe "set_response/2" do
    test "sets the response of the state" do
      state = State.new()
      response = %{}

      assert %State{response: ^response} = State.set_response(state, response)
    end
  end

  describe "get_response/1" do
    test "returns the response of the state" do
      state = State.new()
      response = %{}

      assert ^response = State.get_response(State.set_response(state, response))
    end
  end
end
