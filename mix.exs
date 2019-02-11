defmodule BambooSes.MixProject do
  use Mix.Project

  def project do
    [
      app: :bamboo_ses_adapter,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      docs: docs(),
      elixir: "~> 1.7",
      package: package(),
      source_url: "https://github.com/krystofbe/bamboo_ses_adapter",
      start_permanent: Mix.env() == :prod,
      version: "0.0.1"
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
      {:ex_aws_ses, "~> 2.0.1"},
      {:bamboo, "~> 1.0"},
      {:mail, "~> 0.2.0"},
      {:mox, "~> 0.3", only: :test},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev},
      {:inch_ex, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    "AWS SES adapter for Bamboo with fixes for HTML Mails"
  end

  defp docs do
    [main: "readme", extras: ["README.md"]]
  end

  defp package do
    [
      maintainers: ["Krystof Beuermann <krystof@gmx.biz>"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/krystofbe/bamboo_ses_adapter"}
    ]
  end
end
