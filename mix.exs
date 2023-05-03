defmodule Wexhook.MixProject do
  use Mix.Project

  def project do
    [
      app: :wexhook,
      version: "0.6.1",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      test_coverage: [
        tool: ExCoveralls,
        preferred_cli_env: [
          coveralls: :test,
          "coveralls.detail": :test,
          "coveralls.post": :test,
          "coveralls.html": :test
        ]
      ],
      dialyzer: [
        plt_add_apps: [:mix, :ex_unit],
        check_plt: true
      ],
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Wexhook.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.1"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.18.16"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.7.2"},
      {:esbuild, "~> 0.5", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:timex, "~> 3.7.11"},
      {:prom_ex, git: "https://github.com/glennr/prom_ex", branch: "gr/bump-plug-2.6"},

      # Testing
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:benchee, "~> 1.0", only: [:dev, :test]},
      {:benchee_html, "~> 1.0", only: [:dev, :test]},
      {:k6, "~> 0.2.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
      "dashboard.export": [
        "prom_ex.dashboard.export --dashboard application.json -f dashboards/application.json",
        "prom_ex.dashboard.export --dashboard beam.json -f dashboards/beam.json",
        "prom_ex.dashboard.export --dashboard phoenix.json -f dashboards/phoenix.json",
        "prom_ex.dashboard.export --dashboard phoenix_live_view.json -f dashboards/phoenix_live_view.json"
      ]
    ]
  end
end
