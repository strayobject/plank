defmodule Plank.Repo.Migrations.CardSoftDelete do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    alter table(:cards) do
      soft_delete_columns()
    end
  end
end
