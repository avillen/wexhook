defmodule WexhookWeb.HomeLiveTest do
  use WexhookWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  test "renders the page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/wexhook")

    assert html =~ "Webhook URL"
  end

  test "renders the page for a server fetching a server that doesn't exists", %{conn: conn} do
    id = "server_id"
    conn = get(conn, ~p"/wexhook/share/#{id}")
    {:ok, _view, html} = live(conn)

    assert html =~ "Webhook URL"

    conn = post(conn, ~p"/wexhook/hook/#{id}")
    json_response(conn, 200)

    assert_receive {_, {:push_event, "request_received", %{}}}
  end

  test "renders the page for a server fetching a server that exists", %{conn: conn} do
    {:ok, server_pid} = Wexhook.new_server()
    id = Wexhook.get_server_id(server_pid)

    conn = get(conn, ~p"/wexhook/share/#{id}")
    {:ok, _view, html} = live(conn)

    assert html =~ "Webhook URL"

    conn = post(conn, ~p"/wexhook/hook/#{id}")
    json_response(conn, 200)

    assert_receive {_, {:push_event, "request_received", %{}}}
  end

  test "updates the response when the form is filled and the save button pressed", %{conn: conn} do
    {:ok, server_pid} = Wexhook.new_server()
    id = Wexhook.get_server_id(server_pid)

    conn = get(conn, ~p"/wexhook/share/#{id}")
    {:ok, view, _html} = live(conn)

    html =
      view
      |> element(~s{[id="save_response"]})
      |> render_submit(%{"http-code" => 404, "response-body" => "hello"})

    assert html =~ "404"
    assert html =~ "hello"
  end
end
