defmodule Converter.SendProducerConsumer do
  use GenStage
  @gbp_to_eur 1.10
  @gbp_to_usd 1.30

  # API

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # CALLBACKS

  def init(:ok) do
    {:producer_consumer, :no_state, dispatcher: GenStage.BroadcastDispatcher}
  end

  def handle_events(events, _from, state) do
    converted = convert_to_eur_usd(events, [])
    {:noreply, converted, state}
  end

  # HELPERS

  defp convert_to_eur_usd([], converted) do
    converted
  end

  defp convert_to_eur_usd([%{price_per_share: pps} = event | events], converted) do
    eur = %{
      event |
      price_per_share: round(pps * @gbp_to_eur),
      currency: :eur
    }

    usd = %{
      event |
      price_per_share: round(pps * @gbp_to_usd),
      currency: :usd
    }

    convert_to_eur_usd(events, [eur, usd | converted])
  end
end
