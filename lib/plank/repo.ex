defmodule Plank.Repo do
  use Ecto.Repo,
    otp_app: :plank,
    adapter: Ecto.Adapters.Postgres
  use Ecto.SoftDelete.Repo
end
