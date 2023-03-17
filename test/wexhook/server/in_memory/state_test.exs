defmodule Wexhook.Server.InMemory.StateTest do
  use ExUnit.Case, async: true

  alias Wexhook.Request
  alias Wexhook.Server.InMemory.State

  @public_path "public"

  describe "new/1" do
    test "returns a new state" do
      assert %State{
               public_path: @public_path,
               requests: []
             } == State.new(@public_path)
    end
  end

  describe "add_request/2" do
    test "adds a request to the state" do
      state = State.new(@public_path)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %State{
               public_path: @public_path,
               requests: [^request]
             } = State.add_request(state, request)
    end
  end

  describe "get_requests/1" do
    test "returns the requests in the state" do
      state = State.new(@public_path)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert [^request] = State.get_requests(State.add_request(state, request))
    end
  end

  describe "get_request/2" do
    test "returns the request with the given id" do
      state = State.new(@public_path)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert ^request = State.get_request(State.add_request(state, request), "id")
    end
  end

  describe "delete_request/2" do
    test "deletes the request with the given id" do
      state = State.new(@public_path)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %State{
               public_path: @public_path,
               requests: []
             } == State.delete_request(State.add_request(state, request), "id")
    end
  end

  describe "delete_requests/1" do
    test "deletes all requests" do
      state = State.new(@public_path)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %State{
               public_path: @public_path,
               requests: []
             } == State.delete_requests(State.add_request(state, request))
    end
  end

  describe "get_request_count/1" do
    test "returns the number of requests in the state" do
      state = State.new(@public_path)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert 1 == State.get_request_count(State.add_request(state, request))
    end
  end

  describe "get_public_path/1" do
    test "returns the public path" do
      state = State.new(@public_path)

      assert @public_path == State.get_public_path(state)
    end
  end
end
