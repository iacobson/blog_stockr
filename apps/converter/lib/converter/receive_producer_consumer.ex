defmodule Converter.ReceiveProducerConsumer do
  use GenStage
  use UmbrellaStage,
    type: :producer_consumer,
    producers: [
      {GerMarket.ReceiveProducer, []},
      {UsaMarket.ReceiveProducer, []}
    ]

  @eur_to_gbp 0.90
  @usd_to_gbp 0.75

  # API

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # CALLBACKS

  def init(:ok) do
    umbrella_sync_subscribe()
    {:producer_consumer, :no_state}
  end

  def handle_events(events, _from, state) do
    converted = Enum.map(events, &convert_to_gbp/1)
    {:noreply, converted, state}
  end

  # HELPERS

  defp convert_to_gbp(
    %{price_per_share: pps, currency: :eur} = event
  ) do
    %{
      event |
      price_per_share: round(pps * @eur_to_gbp),
      currency: :gbp
    }
  end

  defp convert_to_gbp(
    %{price_per_share: pps, currency: :usd} = event
  ) do
    %{
      event |
      price_per_share: round(pps * @usd_to_gbp) ,
      currency: :gbp
    }
  end
end
