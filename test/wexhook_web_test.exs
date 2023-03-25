defmodule WexhookWebTest do
  use WexhookWeb.ConnCase, async: true

  alias Phoenix.LiveView.Socket

  describe "get_host_uri/1" do
    test "returns the host uri", %{conn: _conn} do
      socket = %Socket{host_uri: "https://google.com"}

      assert "https://google.com" == WexhookWeb.get_host_uri(socket)
    end

    test "returns the host uri when not_mounted_at_router", %{conn: _conn} do
      socket = %Socket{host_uri: :not_mounted_at_router}

      assert "http://0.0.0.0:4000" == WexhookWeb.get_host_uri(socket)
    end
  end
end
