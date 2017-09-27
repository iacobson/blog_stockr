defmodule GerMarket.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      GerMarket.ReceiveProducer,
      GerMarket.SendConsumer
    ]

    opts = [strategy: :one_for_one, name: GerMarket.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
