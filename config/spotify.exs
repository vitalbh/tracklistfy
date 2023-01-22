use Mix.Config

config :spotify_ex,
  callback_url: "http://localhost:4000/authenticate",
  scopes: ["playlist-read-private", "playlist-modify-private", "playlist-modify-public","user-top-read"],
  user_id: "REPLACE",
  client_id: "REPLACE",
  secret_key: "REPLACE"
