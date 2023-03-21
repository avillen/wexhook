defmodule WexhookWeb.Components.HookCardTest do
  use WexhookWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  alias WexhookWeb.Components.HookCard

  alias Wexhook.Request

  test "renders the component" do
    method = "GET"
    headers = []
    body = "body"
    created_at = DateTime.utc_now()

    request = Request.new("id", method, headers, body, created_at)

    html = render_component(&HookCard.base/1, request: request)
    assert html =~ method
    assert html =~ inspect(headers)
    assert html =~ body
    assert html =~ Timex.format!(created_at, "%F %T", :strftime)
  end
end
