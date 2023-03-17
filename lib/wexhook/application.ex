defmodule Wexhook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: Wexhook.ServersSupervisor},

      # Start the Telemetry supervisor
      WexhookWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Wexhook.PubSub},
      # Start the Endpoint (http/https)
      WexhookWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Wexhook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WexhookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
