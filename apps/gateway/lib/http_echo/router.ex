defmodule HTTPEcho.Gateway.Router do
  @moduledoc false

  use Plug.Router
  use Plug.Debugger

  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  get "/ping" do
    send_resp(conn, 200, "pong")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
