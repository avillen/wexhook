defmodule Wexhook.ResponseTest do
  use ExUnit.Case, async: true

  alias Wexhook.Response

  describe "new/3" do
    test "returns a new response" do
      assert %Response{} = Response.new(200, [], "")
    end
  end
end
