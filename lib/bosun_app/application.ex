defmodule BosunApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BosunAppWeb.Telemetry,
      # Start the Ecto repository
      BosunApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BosunApp.PubSub},
      # Start Finch
      {Finch, name: BosunApp.Finch},
      # Start the Endpoint (http/https)
      BosunAppWeb.Endpoint
      # Start a worker by calling: BosunApp.Worker.start_link(arg)
      # {BosunApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BosunApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BosunAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
