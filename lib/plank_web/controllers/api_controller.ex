defmodule PlankWeb.ApiController do
  use PlankWeb, :controller
  alias Plank.Card

  @topic "boards"

  def update_card(conn, %{"id" => id, "target_column_id" => target_column_id}) do
    with {:ok, card} <- Card.update(id, %{column_id: target_column_id}) do
      new_board = card.column.board

      PlankWeb.Endpoint.broadcast(
        PlankWeb.BoardLive.topic(new_board.id),
        "board:updated",
        new_board
      )

      conn |> json(%{"id" => card.id})
    else
      {:error, _reason} -> conn |> json(%{"error" => "Could not update board"})
    end
  end
end