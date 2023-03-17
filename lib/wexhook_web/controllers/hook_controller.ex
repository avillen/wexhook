defmodule WexhookWeb.HookController do
  use WexhookWeb, :controller

  alias Wexhook.Request
  alias Wexhook.Support.Strings

  def hook(conn, %{"id" => public_path}) do
    case Wexhook.get_server_by_public_path(public_path) do
      nil ->
        conn
        |> put_status(404)
        |> json(%{error: "Server not found"})

      pid ->
        id = Strings.random_string()
        method = conn.method
        headers = conn.req_headers
        body = conn.body_params

        Wexhook.add_request(
          pid,
          Request.new(id, method, headers, body, DateTime.utc_now())
        )

        conn
        |> put_status(200)
        |> json(%{ok: public_path})
    end
  end
end
