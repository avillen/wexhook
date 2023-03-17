defmodule WexhookWeb.HookControllerTest do
  use WexhookWeb.ConnCase, async: true

  import Phoenix.ConnTest

  test "POST /hook/:id", %{conn: conn} do
    conn = post(conn, "/hook/123")
    assert json_response(conn, 200) == %{"ok" => "123"}
  end
end
