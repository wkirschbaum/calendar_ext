defmodule CalendarExt.MixProject do
  use Mix.Project

  def project do
    [
      app: :calendar_ext,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Wilhelm H Kirschbaum"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/wkirschbaum/calendar_ext"}
    ]
  end

  defp description do
    "Additional functions for Date, Time and DateTime."
  end
end
