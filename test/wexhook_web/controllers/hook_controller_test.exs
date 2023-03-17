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
      public_path = Wexhook.get_server_public_path(server_pid)

      conn = post(conn, "/hook/" <> public_path)
      assert json_response(conn, 200) == %{"ok" => public_path}
    end
  end
end
