defmodule WexhookWeb.HookController do
  use WexhookWeb, :controller

  alias Wexhook.Request
  alias Wexhook.Support.Strings

  def hook(conn, %{"id" => id}) do
    case Wexhook.get_server_by_id(id) do
      nil ->
        conn
        |> put_status(404)
        |> json(%{error: "Server not found"})

      pid ->
        request_id = Strings.random_string()
        method = conn.method
        headers = conn.req_headers
        body = conn.body_params

        request = Request.new(request_id, method, headers, body, DateTime.utc_now())

        Wexhook.add_request(pid, request)

        conn
        |> put_status(200)
        |> json(%{ok: id})
    end
  end
end
