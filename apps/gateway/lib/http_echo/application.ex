defmodule HTTPEcho.Gateway.Application do
  @moduledoc false

  use Application

  alias HTTPEcho.Gateway.Router

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: 4080]
      )
    ]

    opts = [strategy: :one_for_one, name: HTTPEcho.Gateway.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
