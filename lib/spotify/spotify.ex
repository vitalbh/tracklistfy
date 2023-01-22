defmodule Tracklist.Spotify do

  def profile(conn) do
    case resp = Spotify.Profile.me(conn) do
      {:ok, %{id: _}} ->
        {:ok, profile} = resp
        profile
      _ ->
        nil
      end
  end
  def search(conn, tracks) do
    tracks
    |> Enum.map(fn x ->
      track_id = get_song(conn, x)
      unless track_id == nil do
        "spotify:track:#{track_id}"
      end
    end)
  end

  def create(conn, profile, playlist) do
      tracks = search(conn, playlist.tracks)
      body = Poison.encode! %{name: "#{playlist.name} (Tracklistfy)", public: true}
      case Spotify.Playlist.create_playlist(conn, profile.id, body) do
        {:ok, %{id: playlist_id,external_urls: %{"spotify" => spotify_url}}} ->
          body = Poison.encode!(%{ uris: tracks})
          case Spotify.Playlist.add_tracks(conn,  profile.id, playlist_id, body, []) do
            {:ok, %{snapshot_id: _}} ->
              spotify_url
            _ ->
              nil
          end
        _ ->
          nil
      end

  end

  defp get_song(conn, elem) do
    q = Enum.join([elem.artist, elem.song], " ")
    case Spotify.Search.query(conn, q: q, type: "track") do
      {:ok, %{items: items}} ->
        %Spotify.Track{id: track_id} = List.first(items)
        track_id
      _ ->
        nil
    end
  end

end
