defmodule WexhookWeb.HookController do
  @moduledoc """
  The hook controller.
  """

  use WexhookWeb, :controller

  alias Wexhook.{Request, Response}
  alias Wexhook.Support.Strings

  alias __MODULE__.Serializer

  def hook(conn, %{"id" => id}) do
    {:ok, pid} = Wexhook.get_server_or_create(id)
    :ok = do_add_request(conn, pid)

    response = Wexhook.get_server_response(pid)
    status = Response.get_status(response)
    body = Response.get_body(response)

    conn
    |> put_status(status)
    |> json(Serializer.parse_body(body))
  end

  defp do_add_request(conn, pid) do
    request_id = Strings.random_string()
    method = Map.fetch!(conn, :method)
    headers = Map.fetch!(conn, :req_headers)
    body = Map.fetch!(conn, :body_params)

    request = Request.new(request_id, method, headers, body, DateTime.utc_now())
    Wexhook.add_request(pid, request)
  end
end
