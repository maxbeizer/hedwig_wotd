defmodule HedwigWotd.MockWotdFetcher do
  @behaviour Wotd

  @moduledoc false

  @impl Wotd
  def fetch, do: %{body: "", status_code: 200}

  @impl Wotd
  def parse(%{body: "", status_code: 200}) do
    {
      :ok,
      "jackleg",
      "adjective: Unskilled; unscrupulous; incompetent. noun: An unskilled or unscrupulous worker.",
      "https://wordsmith.org/words/jackleg.html"
    }
  end

  @impl Wotd
  def parse(%{body: "", status_code: 500}), do: {:error, "Error"}
end
