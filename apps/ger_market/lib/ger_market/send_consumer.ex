defmodule GerMarket.SendConsumer do
  use GenStage

  # API

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # CALLBACKS

  def init(:ok) do
    {:consumer, :no_state}
  end

  def handle_events(events, _from, state) do
    Enum.each(events, &Shared.Interface.process_info(GerMarketInterface, &1))
    {:noreply, [], state}
  end
end
