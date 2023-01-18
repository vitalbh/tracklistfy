defmodule Tracklistfy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Tracklistfy.Repo,
      # Start the Telemetry supervisor
      TracklistfyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tracklistfy.PubSub},
      # Start the Endpoint (http/https)
      TracklistfyWeb.Endpoint
      # Start a worker by calling: Tracklistfy.Worker.start_link(arg)
      # {Tracklistfy.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tracklistfy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TracklistfyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
