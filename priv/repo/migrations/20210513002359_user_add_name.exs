defmodule Plank.Repo.Migrations.UserAddName do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
      add :nickname, :string
    end
  end
end
