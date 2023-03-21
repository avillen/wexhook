defmodule Wexhook.Server.InMemory.StateTest do
  use ExUnit.Case, async: true

  alias Wexhook.Request
  alias Wexhook.Server.InMemory.State

  @id "public"

  describe "new/1" do
    test "returns a new state" do
      assert %State{
               id: @id,
               requests: []
             } == State.new(@id)
    end
  end

  describe "add_request/2" do
    test "adds a request to the state" do
      state = State.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %State{
               id: @id,
               requests: [^request]
             } = State.add_request(state, request)
    end
  end

  describe "get_requests/1" do
    test "returns the requests in the state" do
      state = State.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert [^request] = State.get_requests(State.add_request(state, request))
    end
  end

  describe "get_request/2" do
    test "returns the request with the given id" do
      state = State.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert ^request = State.get_request(State.add_request(state, request), "id")
    end
  end

  describe "delete_request/2" do
    test "deletes the request with the given id" do
      state = State.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %State{
               id: @id,
               requests: []
             } == State.delete_request(State.add_request(state, request), "id")
    end
  end

  describe "delete_requests/1" do
    test "deletes all requests" do
      state = State.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %State{
               id: @id,
               requests: []
             } == State.delete_requests(State.add_request(state, request))
    end
  end

  describe "get_request_count/1" do
    test "returns the number of requests in the state" do
      state = State.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert 1 == State.get_request_count(State.add_request(state, request))
    end
  end

  describe "get_id/1" do
    test "returns the public path" do
      state = State.new(@id)

      assert @id == State.get_id(state)
    end
  end
end
