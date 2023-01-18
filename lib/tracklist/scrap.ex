defmodule Tracklist.Scrap do
  alias Floki
  def tracks(url) do
    {status, body} = fetch(url)
    case status do
      :ok ->
        {:ok, document} = Floki.parse_document(body)
        document
        |> Floki.find("li.-song")
        |> Enum.map(&parse_row/1)
      :error ->
        []
    end
  end

  defp parse_row(e), do: %{artist: Floki.attribute(e, "data-artist"), song: Floki.attribute(e, "data-name")}

  defp fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found :("}
        {:ok, %HTTPoison.Response{status_code: 301}} ->
          {:error, "Not found :("}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
