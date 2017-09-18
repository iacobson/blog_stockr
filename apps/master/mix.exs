defmodule Master.Mixfile do
  use Mix.Project

  def project do
    [
      app: :master,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Master.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ger_market, in_umbrella: true},
      {:usa_market, in_umbrella: true},
      {:converter, in_umbrella: true},
      {:my_uk_app, in_umbrella: true}
    ]
  end
end
