defmodule Wexhook.ResponseTest do
  use ExUnit.Case, async: true

  alias Wexhook.Response

  describe "new/3" do
    test "returns a new response" do
      assert %Response{} = Response.new(200, [], "")
    end
  end

  describe "get_status/1" do
    test "returns the status" do
      assert 200 = Response.get_status(Response.new(200, [], ""))
    end
  end

  describe "get_headers/1" do
    test "returns the headers" do
      assert [] = Response.get_headers(Response.new(200, [], ""))
    end
  end

  describe "get_body/1" do
    test "returns the body" do
      assert "" = Response.get_body(Response.new(200, [], ""))
    end
  end
end
