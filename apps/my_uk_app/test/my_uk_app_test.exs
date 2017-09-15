defmodule MyUkAppTest do
  use ExUnit.Case
  doctest MyUkApp

  test "greets the world" do
    assert MyUkApp.hello() == :world
  end
end
