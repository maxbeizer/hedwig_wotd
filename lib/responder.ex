defmodule HedwigWotd.Responder do
  @moduledoc """
  Word of the day

  Replies with a word of the day with a definition
  """

  use Hedwig.Responder

  @fetcher Application.get_env(:hedwig_wotd, :fetcher, HedwigWotd.Fetcher)

  @usage """
  hedwig wotd - Replies with the word of the day, the defintion, and a link
  for more info.
  """
  respond ~r/wotd/i, msg do
    result =
      @fetcher.fetch()
      |> @fetcher.parse()

    response =
      case result do
        {:ok, word, description, link} -> "#{word} => #{description} #{link}"
        {:error, error_string} -> error_string
      end

    send(msg, response)
  end
end
