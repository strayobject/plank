defmodule Plank.Board do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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
      board -> {:ok, get_preloaded_board(board.id)}
    end
  end

  #todo need to filter out soft deleted cards.
  defp get_preloaded_board(board_id) do
    board = Plank.Board
      |> where([b], b.id == ^board_id)
      |> join(:left, [b], c in assoc(b, :columns))
      |> join(:left, [b, c], ca in assoc(c, :cards))
      |> join(:left, [b, c, ca], u in assoc(ca, :user))
      |> preload([b, c, ca, u], [columns: {c, cards: {ca, user: u}}])
      |> Plank.Repo.one
  end
end
