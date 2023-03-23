defmodule WexhookWeb.HomeLiveTest do
  use WexhookWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  test "renders the page", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/")

    assert html =~ "Webhook URL"
  end

  test "renders the page for a server fetching a server that doesn't exists", %{conn: conn} do
    id = "server_id"
    conn = get(conn, "/share/" <> id)
    {:ok, _view, html} = live(conn)

    assert html =~ "Webhook URL"

    conn = post(conn, "/hook/" <> id)
    json_response(conn, 200)

    assert_receive {_, {:push_event, "request_received", %{}}}
  end

  test "renders the page for a server fetching a server that exists", %{conn: conn} do
    {:ok, server_pid} = Wexhook.new_server()
    id = Wexhook.get_server_id(server_pid)

    conn = get(conn, "/share/" <> id)
    {:ok, _view, html} = live(conn)

    assert html =~ "Webhook URL"

    conn = post(conn, "/hook/" <> id)
    json_response(conn, 200)

    assert_receive {_, {:push_event, "request_received", %{}}}
  end
end
