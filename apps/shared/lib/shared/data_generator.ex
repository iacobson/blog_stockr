defmodule Shared.DataGenerator do
  def generate do
    for _x <- in (1 .. 1000) do
      
    end
  end


  defp generate(:usa) do
    random_sleep()
    UsaMarket.ReceiveProducer.receive_info(
      %{
        company: "USA: #{random_name()}",
        price_per_share: random_price(),
        currency: :usd
      }
    )
  end


  defp generate(:ger) do
    random_sleep()
    UsaMarket.ReceiveProducer.receive_info(
      %{
        company: "GER: #{random_name()}",
        price_per_share: random_price(),
        currency: :eur
      }
    )
  end

  defp generate(:uk) do
    random_sleep()
    UsaMarket.ReceiveProducer.receive_info(
      %{
        company: "UK: #{random_name()}",
        price_per_share: random_price(),
        currency: :gbp
      }
    )
  end



  defp random_price do
    Enum.random(1 .. 1000)
  end

  defp random_name do
    Enum.random(["A", "B", "C", "D", "E", "F"])
  end

  defp random_sleep do
    Enum.random (1000 .. 3000) |> :timer.sleep()
  end
end
