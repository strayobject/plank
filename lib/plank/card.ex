defmodule Plank.Card do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import Ecto.SoftDelete.Schema
  alias Plank.{Repo, Card}

  schema "cards" do
    field :content, :string
    field :order, :integer, default: 1
    belongs_to :column, Plank.Column
    belongs_to :user, Plank.Users.User

    timestamps()
    soft_delete_schema()
  end

  def update(id, changes) do
    with card when not is_nil(card) <- Repo.get(Card, id),
         {:ok, card} <- do_update(card, changes) do
      {:ok, card |> Repo.preload([:user, column: :board])} # need to preload user here as well
#      {:ok, get_preloaded_card(card.id)} does not seem to work
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp get_preloaded_card(card_id) do
    card = Plank.Card
      |> where([ca], ca.id == ^card_id)
      |> join(:left, [ca], u in assoc(ca, :user))
      |> join(:left, [ca, u], c in assoc(ca, :column))
      |> join(:left, [ca, u, c], b in assoc(c, :board))
      |> preload([ca, u, c, b], [user: u, column: {c, board: b}])
      |> Plank.Repo.one
  end

  defp do_update(card, changes) do
    IO.puts "hello update <<<<<<<<<<<<<<<<<<<<<<"
    IO.inspect binding()
    card
    |> changeset(changes)
    |> Repo.update()
  end

  def update_sort_order(cards) do
    IO.puts "hello here >>>>>>>>>>>>>>>>>>>>"
    IO.inspect binding()
    cards
    |> Enum.with_index(1)
    |> Enum.each(
         fn {v,k} ->
           IO.inspect binding()
           Card.update(v, %{order: k})
         end
       )
  end

  defp prepare_sort_order_card() do

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
    |> cast(attrs, [:content, :column_id, :user_id])
    |> validate_required([:content])
  end
end
