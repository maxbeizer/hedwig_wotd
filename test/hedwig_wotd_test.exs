defmodule HedwigWotdTest do
  use ExUnit.Case
  doctest HedwigWotd

  test "greets the world" do
    assert HedwigWotd.hello() == :world
  end
end
