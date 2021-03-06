defmodule AgileTools.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      AgileTools.Repo,
      # Start the Telemetry supervisor
      AgileToolsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AgileTools.PubSub},
      # Start the Endpoint (http/https)
      AgileToolsWeb.Endpoint,
      # Start a worker by calling: AgileTools.Worker.start_link(arg)
      # {AgileTools.Worker, arg}
      {Oban, oban_config()},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AgileTools.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AgileToolsWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp oban_config do # Add this line
    Application.fetch_env!(:agile_tools, Oban)
  end
end
