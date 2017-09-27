defmodule MyUkApp.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      MyUkApp.ReceiveConsumer,
      MyUkApp.SendProducer
    ]

    opts = [strategy: :one_for_one, name: MyUkApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
