defmodule WexhookWeb.Router do
  use WexhookWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WexhookWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WexhookWeb do
    pipe_through :api

    get "/status", StatusController, :show
  end

  scope "/hook", WexhookWeb do
    pipe_through :api

    post "/:id", HookController, :hook
  end

  scope "/", WexhookWeb do
    pipe_through :browser

    live "/", HomeLive
    live "/share/:id", HomeLive
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:wexhook, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WexhookWeb.Telemetry
    end
  end
end
