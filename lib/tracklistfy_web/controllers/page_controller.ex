defmodule TracklistfyWeb.PageController do
  use TracklistfyWeb, :controller
  plug TracklistfyWeb.Plugs.Auth

  def index(conn, %{"url" => url} = _params) do
    {:ok, playlist} = Tracklist.Letras.tracks(url)
    profile = Tracklist.Spotify.profile(conn)
    render(conn, "index.html", url: url, playlist: playlist, profile: profile, spotify_url: nil)
  end
  def index(conn, _) do
    profile = Tracklist.Spotify.profile(conn)
    render(conn, "index.html", url: nil ,playlist: nil, profile: profile, spotify_url: nil)
  end
  def create(conn, %{"_method" => "post","url" => url} = _params) do
    {:ok, playlist} = Tracklist.Letras.tracks(url)
    profile = Tracklist.Spotify.profile(conn)
    unless profile == nil do
      spotify_url = Tracklist.Spotify.create(conn, profile, playlist)
      render(conn, "index.html", url: url, playlist: playlist, profile: profile, spotify_url: spotify_url)
    else
      Phoenix.Controller.redirect conn, external: "/authorize"
    end

  end

end
