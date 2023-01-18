defmodule TracklistfyWeb.PageController do
  use TracklistfyWeb, :controller

  def index(conn, %{"url" => url} = _params) do
    tracks = Tracklist.Scrap.tracks(url)
    render(conn, "index.html", tracks: tracks)
  end
  def index(conn, _) do
    render(conn, "index.html", tracks: [])
  end
end
