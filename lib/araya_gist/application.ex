defmodule ArayaGist.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ArayaGistWeb.Telemetry,
      ArayaGist.Repo,
      {DNSCluster, query: Application.get_env(:araya_gist, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ArayaGist.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ArayaGist.Finch},
      # Start a worker by calling: ArayaGist.Worker.start_link(arg)
      # {ArayaGist.Worker, arg},
      # Start to serve requests, typically the last entry
      ArayaGistWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ArayaGist.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ArayaGistWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
