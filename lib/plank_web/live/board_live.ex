defmodule PlankWeb.BoardLive do
  use PlankWeb, :live_view

  def mount(_params, %{"board_id" => board_id}, socket) do
    with {:ok, board} <- Plank.Board.find(board_id) do
      PlankWeb.Endpoint.subscribe(topic(board_id))
      {:ok, assign(socket, :board, board)}
    else
      {:error, _reason} ->
        {:ok, redirect(socket, to: "/error")}
    end
  end

  def handle_event("add_card", %{"column" => column_id}, socket) do
    {id, _} = Integer.parse(column_id)
    %Plank.Card{column_id: id, content: "Something new"} |> Plank.Repo.insert!()
    {:ok, new_board} = Plank.Board.find(socket.assigns.board.id)
    PlankWeb.Endpoint.broadcast(topic(new_board.id), "board:updated", new_board)
    {:noreply, assign(socket, :board, new_board)}
  end

  def handle_event("delete_card", %{"card" => card_id}, socket) do
    IO.inspect binding()
    {id, _} = Integer.parse(card_id)
    Plank.Card.soft_delete_card(id)
    {:ok, new_board} = Plank.Board.find(socket.assigns.board.id)
    PlankWeb.Endpoint.broadcast(topic(new_board.id), "board:updated", new_board)
    {:noreply, assign(socket, :board, new_board)}
  end

  def handle_event("update_card", params, socket) do
    IO.inspect binding()
    card_id = params["card"]
    new_content = String.trim(params["value"])
    {id, _} = Integer.parse(card_id)
    Plank.Card.update(id, %{content: new_content})
    {:ok, new_board} = Plank.Board.find(socket.assigns.board.id)
    PlankWeb.Endpoint.broadcast(topic(new_board.id), "board:updated", new_board)
    {:noreply, assign(socket, :board, new_board)}
  end

  def handle_event("update_column", params, socket) do
    IO.inspect binding()
    column_id = params["column"]
    new_content = params["value"]
    {id, _} = Integer.parse(column_id)
    Plank.Column.update(id, %{title: new_content})
    {:ok, new_board} = Plank.Board.find(socket.assigns.board.id)
    PlankWeb.Endpoint.broadcast(topic(new_board.id), "board:updated", new_board)
    {:noreply, assign(socket, :board, new_board)}
  end

  def handle_info(%{topic: message_topic, event: "board:updated", payload: board}, socket) do
    cond do
      topic(board.id) == message_topic ->
        {:noreply, assign(socket, :board, Plank.Repo.preload(board, columns: :cards))}
      true ->
        {:noreply, socket}
    end
  end

  def topic(board_id) do
    "board:#{board_id}"
  end
end
