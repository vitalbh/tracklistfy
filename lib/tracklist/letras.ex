defmodule Playlist do
  defstruct name: nil, tracks: nil
end

defmodule Tracklist.Letras do


  alias Floki
  def tracks(url) do
    url = URI.decode(url)
    case Tracklist.Letras.valid?(url) do
      true ->
      {status, body} = fetch(url)
      case status do
        :ok ->
          {:ok, document} = Floki.parse_document(body)
          tracks = extract_tracklist(document)
          name = extract_name(document)
          {:ok, %Playlist{name: name, tracks: tracks}}
        :error ->
          {:error, %Playlist{}}
      end
      false ->
        {:error, %Playlist{}}
    end
  end
  defp extract_tracklist(document) do
    document
      |> Floki.find("li.-song")
      |> Enum.map(&parse_row/1)
  end
  defp extract_name(document) do
    document
      |> Floki.find("h1.header-name")
      |> Floki.text()
  end

  def valid?(url) do
    String.match?(url, ~r/https:\/\/(www|m)\.letras\.(mus\.br|com)\/playlists\/(.*)+\/$/)
  end
  defp parse_row(e), do: %{artist: Floki.attribute(e, "data-artist"), song: Floki.attribute(e, "data-name")}

  defp fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}
      {:ok, %HTTPoison.Response{status_code: status}} ->
        {:error, status}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
