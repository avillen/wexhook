defmodule WexhookWeb.HookController do
  use WexhookWeb, :controller

  def hook(conn, %{"id" => public_path}) do
    json(conn, %{"ok" => public_path})
  end
end
