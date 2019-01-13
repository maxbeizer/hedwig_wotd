defmodule HedwigWotd.Fetcher do
  @behaviour Wotd

  @moduledoc """
  Fetches and parses the word of the day from the feed. Formats the data into a
  format for the bot.
  """

  @wotd_url "https://wordsmith.org/awad/rss1.xml"
  @error_response "There was an error fetching the word of the day."

  @impl Wotd
  def fetch do
    case HTTPoison.get(@wotd_url) do
      {:ok, body} -> body
      _ -> %{error_response: @error_response}
    end
  end

  @impl Wotd
  def parse(%{body: body, status_code: status_code}) when status_code == 200 do
    body
    |> Quinn.parse()
    |> Quinn.find(:item)
    |> extract_info_from_item()
  end

  def parse(%{status_code: code}), do: {:error, "API returned #{code}. OH NO!!"}
  def parse(%{error_response: error_response}), do: {:error, error_response}

  defp extract_info_from_item([%{value: [word, link, description]}]) do
    %{value: [word_value]} = word
    %{value: [link_value]} = link
    %{value: [description_value]} = description
    {:ok, word_value, description_value, link_value}
  end
end
