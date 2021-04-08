# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :plank,
  ecto_repos: [Plank.Repo]

# Configures the endpoint
config :plank, PlankWeb.Endpoint,
  url: [host: "app"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: PlankWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Plank.PubSub,
  live_view: [signing_salt: System.get_env("LIVE_VIEW_SALT")]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :plank, :pow,
  user: Plank.Users.User,
  repo: Plank.Repo,
  web_module: PlankWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
