defmodule Master.ReceiveInfoTest do
  use ExUnit.Case

  test "receive stock market info in GBP from US and Germany" do
    {:ok, _interface} = Shared.Interface.start_link(MyUkAppInterface, self())

    usa_info = [
      %{company: "A", price_per_share: 100, currency: :usd},
      %{company: "B", price_per_share: 400, currency: :usd}
    ]

    ger_info = [
      %{company: "C", price_per_share: 180, currency: :eur},
      %{company: "D", price_per_share: 320, currency: :eur}
    ]

    Enum.each(usa_info, &GerMarket.ReceiveProducer.receive_info/1)
    Enum.each(ger_info, &UsaMarket.ReceiveProducer.receive_info/1)

    expected_info = [
      %{company: "A", price_per_share:  75, currency: :gbp},
      %{company: "B", price_per_share: 300, currency: :gbp},
      %{company: "C", price_per_share: 162, currency: :gbp},
      %{company: "D", price_per_share: 288, currency: :gbp}
    ]

    for info <- expected_info do
      assert_receive {:received, ^info}
    end
  end
end
