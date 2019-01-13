defmodule HedwigWotd.ResponderTest do
  @moduledoc false

  use HedwigWotd.RobotCase, responders: [{HedwigWotd.Responder, []}]

  test "wotd - responds with the word of the day", %{adapter: adapter, msg: msg} do
    send(adapter, {:message, %{msg | text: "hedwig wotd"}})
    assert_receive {:message, %{text: text}}
    assert String.contains?(text, "https://wordsmith.org")
  end
end
