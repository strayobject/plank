defmodule Plank.Repo.Migrations.CardAddOrder do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :order, :integer, default: 1
    end
  end
end
