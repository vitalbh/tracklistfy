defmodule Tracklistfy.Repo do
  use Ecto.Repo,
    otp_app: :tracklistfy,
    adapter: Ecto.Adapters.SQLite3
end
