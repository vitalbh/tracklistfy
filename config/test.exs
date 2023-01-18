import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :tracklistfy, Tracklistfy.Repo,
  database: Path.expand("../tracklistfy_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tracklistfy, TracklistfyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jDDq+M4gWPx1dlyJNhEJZoPYBUEuNTRKyq8CGy7mUxzVeqcuH0cRdoPx2YjIsheU",
  server: false

# In test we don't send emails.
config :tracklistfy, Tracklistfy.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
