defmodule Master.SendInfoTest do
  test "send out stock market info in EUR and USD" do
    {:ok, _interface} = GerMarket.Interface.start_link(self())
    {:ok, _interface} = UsaMarket.Interface.start_link(self())
    GenServer.sync_subscribe(GerMarket.SendConsumer, to: Converter.SendProducerConsumer)
    GenServer.sync_subscribe(UsaMarket.SendConsumer, to: Converter.SendProducerConsumer)
    GenServer.sync_subscribe(Converter.SendProducerConsumer, to: MyUkApp.SendProducer)

    uk_info = [
      %{company: "E", price_per_share: 200, currency: :gbp},
      %{company: "F", price_per_share: 300, currency: :gbp}
    ]

    Enum.each(uk_info, MyUkApp.SendProducer.send_info/1)

    expected_info = [
      %{company: "E", price_per_share: 220, currency: :eur},
      %{company: "F", price_per_share: 330, currency: :eur},
      %{company: "E", price_per_share: 260, currency: :usd},
      %{company: "F", price_per_share: 390, currency: :usd}
    ]

    for info <- expected_info do
      assert_receive {:received, info}
    end
  end
end
