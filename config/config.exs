# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :wexhook, Wexhook.PromEx,
  disabled: false,
  manual_metrics_start_delay: :no_delay,
  drop_metrics_groups: [],
  grafana: :disabled,
  metrics_server: :disabled

config :wexhook,
  hook_base_path: "/wexhook/hook/",
  share_base_path: "/wexhook/share/"

# Configure server adapter
config :wexhook, Wexhook.ServerRepo, adapter: Wexhook.Server.InMemory

# Configures the endpoint
config :wexhook, WexhookWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: WexhookWeb.ErrorHTML, json: WexhookWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Wexhook.PubSub,
  live_view: [signing_salt: "FrcZ8zFB"],
  adapter: Bandit.PhoenixAdapter

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
