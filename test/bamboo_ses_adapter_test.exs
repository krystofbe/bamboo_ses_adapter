defmodule BambooSesAdapterTest do
  use ExUnit.Case
  doctest BambooSesAdapter

  test "greets the world" do
    assert BambooSesAdapter.hello() == :world
  end
end
