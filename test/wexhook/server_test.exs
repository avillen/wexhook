defmodule Wexhook.ServerTest do
  use ExUnit.Case, async: true

  alias Wexhook.{
    Request,
    Response,
    Server
  }

  @id "public"

  describe "new/1" do
    test "returns a new server" do
      assert %Server{
               id: @id,
               requests: [],
               response: Response.new()
             } == Server.new(@id)
    end
  end

  describe "add_request/2" do
    test "adds a request to the server" do
      server = Server.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %Server{
               id: @id,
               requests: [^request]
             } = Server.add_request(server, request)
    end
  end

  describe "get_requests/1" do
    test "returns the requests in the server" do
      server = Server.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert [^request] = Server.get_requests(Server.add_request(server, request))
    end
  end

  describe "get_request/2" do
    test "returns the request with the given id" do
      server = Server.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert ^request = Server.get_request(Server.add_request(server, request), "id")
    end
  end

  describe "delete_request/2" do
    test "deletes the request with the given id" do
      server = Server.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %Server{
               id: @id,
               requests: [],
               response: Response.new()
             } == Server.delete_request(Server.add_request(server, request), "id")
    end
  end

  describe "delete_requests/1" do
    test "deletes all requests" do
      server = Server.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert %Server{
               id: @id,
               requests: [],
               response: Response.new()
             } == Server.delete_requests(Server.add_request(server, request))
    end
  end

  describe "get_request_count/1" do
    test "returns the number of requests in the server" do
      server = Server.new(@id)
      request = Request.new("id", :get, [], "body", DateTime.utc_now())

      assert 1 == Server.get_request_count(Server.add_request(server, request))
    end
  end

  describe "get_id/1" do
    test "returns the public path" do
      server = Server.new(@id)

      assert @id == Server.get_id(server)
    end
  end

  describe "set_response/2" do
    test "sets the response" do
      server = Server.new(@id)
      response = Response.new(200, [], "body")

      assert %Server{
               id: @id,
               requests: [],
               response: ^response
             } = Server.set_response(server, response)
    end
  end

  describe "get_response/1" do
    test "returns the response" do
      server = Server.new(@id)
      response = Response.new(200, [], "body")

      server = Server.set_response(server, response)

      assert ^response = Server.get_response(server)
    end
  end
end
