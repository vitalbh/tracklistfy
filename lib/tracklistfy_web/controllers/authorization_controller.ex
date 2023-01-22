defmodule TracklistfyWeb.AuthorizationController do
  use TracklistfyWeb, :controller

  def authorize(conn, _params) do
    redirect conn, external: Spotify.Authorization.url
  end
end
