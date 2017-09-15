defmodule ConverterTest do
  use ExUnit.Case
  doctest Converter

  test "greets the world" do
    assert Converter.hello() == :world
  end
end
