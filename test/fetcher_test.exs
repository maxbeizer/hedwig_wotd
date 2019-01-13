defmodule HedwigWotd.FetcherTest do
  use ExUnit.Case

  alias HedwigWotd.Fetcher

  describe "parse/1" do
    test "when status_code is 200 and body in response" do
      test_response = %{
        body: """
        <?xml version=\"1.0\" encoding=\"UTF-8\" ?> \n<rss version=\"2.0\" xmlns:atom=\"http://www.w3.org/2005/Atom\">\n<channel>\n<atom:link href=\"http://wordsmith.org/awad/rss1.xml\" rel=\"self\" type=\"application/rss+xml\" />\n\n<title>Wordsmith.org: Today's Word</title> \n<link>http://wordsmith.org/</link> \n<copyright>Copyright 1994-2017 Wordsmith.org</copyright> \n<description>The magic of words - that's what Wordsmith.org is about.</description>\n<language>en-us</language> \n<ttl>1440</ttl> \n\n<item>\n<title>jackleg</title>\n<link>https://wordsmith.org/words/jackleg.html</link>\n<description>adjective: Unskilled; unscrupulous; incompetent. noun: An unskilled or unscrupulous worker.</description>\n</item>\n\n</channel>\n</rss>\n
        """,
        status_code: 200
      }

      expected = {
        :ok,
        "jackleg",
        "adjective: Unskilled; unscrupulous; incompetent. noun: An unskilled or unscrupulous worker.",
        "https://wordsmith.org/words/jackleg.html"
      }

      assert expected == Fetcher.parse(test_response)
    end

    test "when status_code is not 200" do
      test_response = %{
        body: """
        Probably some error
        """,
        status_code: 500
      }

      expected = {
        :error,
        "API returned 500. OH NO!!"
      }

      assert expected == Fetcher.parse(test_response)
    end

    test "when response has error_response key" do
      error_response = "There was an error fetching the word of the day."

      test_response = %{
        error_response: error_response
      }

      expected = {
        :error,
        error_response
      }

      assert expected == Fetcher.parse(test_response)
    end
  end
end
