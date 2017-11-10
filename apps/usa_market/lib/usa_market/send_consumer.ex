defmodule UsaMarket.SendConsumer do
  use GenStage
  use UmbrellaStage,
    type: :consumer,
    producers: [{
        Converter.SendProducerConsumer,
        [selector: fn(%{currency: currency}) -> currency == :usd end]
      }]

  # API

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # CALLBACKS

  def init(:ok) do
    umbrella_sync_subscribe()
    {:consumer, :no_state}
  end

  def handle_events(events, _from, state) do
    #Enum.each(events, &Shared.Interface.process_info(UsaMarketInterface, &1))
    Enum.each(events, &(IO.inspect(&1, label: "[US interface] ")))
    {:noreply, [], state}
  end
end
