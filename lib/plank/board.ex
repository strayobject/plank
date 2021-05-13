defmodule Plank.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :title, :string
    has_many :columns, Plank.Column

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

  def find(id) do
    case Plank.Board |> Plank.Repo.get(id) do
      nil -> {:error, :not_found}
      IO.inspect binding()
      board -> {:ok, board |> Plank.Repo.preload(columns: :cards)}
    end
  end
end
