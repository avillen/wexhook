defmodule WexhookWeb.HomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :hola, "hola")}
  end
end
