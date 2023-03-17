defmodule Wexhook.RequestTest do
  use ExUnit.Case, async: true

  alias Wexhook.Request

  test "new/5" do
    request = Request.new("id", "GET", [], "body")

    assert "id" == request.id
    assert "GET" == request.method
    assert [] == request.headers
    assert "body" == request.body
  end
end
