defmodule WexhookWeb.HookControllerTest do
  use WexhookWeb.ConnCase, async: true

  import Phoenix.ConnTest

  describe "POST /hook/:id" do
    test "when the server does not exists, creates a new one and adds the request", %{conn: conn} do
      id = "123"
      conn = post(conn, "/hook/" <> id)
      assert json_response(conn, 200) == %{"ok" => id}
      assert Wexhook.get_server_by_id(id) != nil
    end

    test "when the server exists, adds the request", %{conn: conn} do
      {:ok, server_pid} = Wexhook.new_server()
      id = Wexhook.get_server_id(server_pid)

      conn = post(conn, "/hook/" <> id)
      assert json_response(conn, 200) == %{"ok" => id}
    end
  end
end
