defmodule GerMarket.ReceiveProducer do
  use GenStage

  # API

  def start_link(_opts) do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def receive_info(event) do
    GenStage.call(__MODULE__, {:receive_info, event})
  end

  # CALLBACKS

  def init(:ok) do
    {:producer, :no_state}
  end

  def handle_call({:receive_info, event}, _from, state) do
    {:reply, :ok, [event], state}
  end

  def handle_demand(_demand, state) do
    {:noreply, [], state}
  end
end
