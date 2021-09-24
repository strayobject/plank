defmodule Plank.Repo.Migrations.CardReferenceUser do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :user_id, references(:users)
    end
  end
end
