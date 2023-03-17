defmodule WexhookWeb.HomeLiveTest do
  use WexhookWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  test "renders the page", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/")

    assert html =~ "Webhook URL"
  end
end
