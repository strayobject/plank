defmodule Plank.Card do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  alias Plank.{Repo, Card}

  schema "cards" do
    field :content, :string
    field :order, :integer, default: 1
    belongs_to :column, Plank.Column

    timestamps()
    soft_delete_schema()
  end

  def update(id, changes) do
    with card when not is_nil(card) <- Repo.get(Card, id),
         {:ok, card} <- do_update(card, changes) do
      {:ok, card |> Repo.preload(column: :board)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_update(card, changes) do
    IO.inspect binding()
    card
    |> changeset(changes)
    |> Repo.update()
  end

  def soft_delete_card(id) do
    %Card{id: id}
    |> Repo.soft_delete()
  end

  def delete_card(id) do
    %Card{id: id}
    |> Repo.delete()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:content, :column_id])
    |> validate_required([:content])
  end
end
