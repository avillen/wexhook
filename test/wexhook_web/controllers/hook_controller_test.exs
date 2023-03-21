defmodule WexhookWeb.HookControllerTest do
  use WexhookWeb.ConnCase, async: true

  import Phoenix.ConnTest

  describe "POST /hook/:id" do
    test "when the server doesn't exists", %{conn: conn} do
      conn = post(conn, "/hook/123")
      assert json_response(conn, 404) == %{"error" => "Server not found"}
    end

    test "when the server exists, adds the request", %{conn: conn} do
      {:ok, server_pid} = Wexhook.new_server()
      id = Wexhook.get_server_id(server_pid)

      conn = post(conn, "/hook/" <> id)
      assert json_response(conn, 200) == %{"ok" => id}
    end
  end
end
