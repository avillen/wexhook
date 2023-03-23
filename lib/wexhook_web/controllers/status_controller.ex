defmodule WexhookWeb.StatusController do
  @moduledoc """
  Health check controller.
  """

  use Phoenix.Controller, namespace: WexhookWeb, log: false

  def show(conn, _params) do
    # When Plug.Cowboy.Drainer is invoked no new connection will be accepted
    case :ranch.get_status(WexhookWeb.Endpoint.HTTP) do
      :suspended ->
        conn
        |> put_status(:service_unavailable)
        |> json(%{status: "unavailable"})

      _ ->
        conn
        |> put_status(:ok)
        |> json(%{status: "ok"})
    end
  end
end
