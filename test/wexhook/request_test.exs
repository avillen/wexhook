defmodule Wexhook.RequestTest do
  use ExUnit.Case, async: true

  alias Wexhook.Request

  test "new/5" do
    created_at = DateTime.utc_now()
    request = Request.new("id", "GET", [], "body", created_at)

    assert "id" == request.id
    assert "GET" == request.method
    assert [] == request.headers
    assert "body" == request.body
    assert created_at == request.created_at
  end
end
