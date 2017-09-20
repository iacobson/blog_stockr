defmodule Shared.Interface do
  use GenServer

  # API

  def start_link(name, test_pid) do
    GenServer.start_link(__MODULE__, test_pid, name: name)
  end

  def process_info(name, event) do
    GenServer.handle_call(name, {:process_info, event})
  end

  # CALLBACKS

  def init(test_pid) do
    {:ok, test_pid}
  end

  def handle_call({:process_info, event}, _from , test_pid) do
    send(test_pid, {:received, event})
    {:reply, :ok, test_pid}
  end
end
