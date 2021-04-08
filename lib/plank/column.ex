defmodule Plank.Column do
  use Ecto.Schema
  import Ecto.Changeset
  alias Plank.{Repo, Column}

  schema "columns" do
    field :title, :string
    belongs_to :board, Plank.Board
    has_many :cards, Plank.Card

    timestamps()
  end

  def update(id, changes) do
    with column when not is_nil(column) <- Repo.get(Column, id),
         {:ok, column} <- do_update(column, changes) do
      {:ok, column |> Repo.preload(column: :board)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_update(column, changes) do
    column
    |> changeset(changes)
    |> Repo.update()
  end

  @doc false
  def changeset(column, attrs) do
    column
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
