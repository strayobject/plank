defmodule Plank.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :name, :string
    field :nickname, :string
    has_many :cards, Plank.Card

    timestamps()
  end

  def nice_name(user) do
    cond do
      !is_nil(user.nickname) ->
        user.nickname
      !is_nil(user.name) ->
        user.name
      true ->
        user.email
    end
  end
end
