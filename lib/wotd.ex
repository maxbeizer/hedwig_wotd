defmodule Wotd do
  @moduledoc """
  Behaviour to allow mocking of Wotd fetcher.
  """

  @doc """
  Hits the wordsmith API for the word of the response
  """
  @callback fetch() :: %{body: String.t(), status_code: integer}

  @doc """
  Given a map with a body and status_code of 200, the function returns a four
  tuple of {:ok, word, description, link}
  """
  @callback parse(%{body: String.t(), status_code: integer}) ::
              {:ok, String.t(), String.t(), String.t()} | {:error, String.t()}
end
