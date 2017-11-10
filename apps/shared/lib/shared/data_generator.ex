defmodule Shared.DataGenerator do
  def generate do
    for _x <- (1 .. 1000) do
      [{"US", :usd}, {"GER", :eur}, {"UK", :gbp}] |> Enum.random() |> generate()
    end
  end


  defp generate({"US", _} = data) do
    event = event(data)
    random_sleep()
    IO.inspect(event, label: "[US interface] ")
    UsaMarket.ReceiveProducer.receive_info(event)
  end

  defp generate({"GER", _} = data) do
    event = event(data)
    random_sleep()
    IO.inspect(event, label: "[GER interface] ")
    GerMarket.ReceiveProducer.receive_info(event)
  end

  defp generate({"UK", _} = data) do
    event = event(data)
    random_sleep()
    IO.inspect(event, label: "[UK interface] ")
    MyUkApp.SendProducer.send_info(event)
  end


  defp event({location, currency}) do
    %{
      company: "company: #{location}: #{random_name()}",
      price_per_share: random_price(),
      currency: currency
    }
  end


  defp random_price do
    Enum.random(1 .. 1000)
  end


  defp random_name do
    Enum.random(["A", "B", "C", "D", "E", "F"])
  end


  defp random_sleep do
    time = Enum.random (1000 .. 3000)
    :timer.sleep(time)
  end
end
