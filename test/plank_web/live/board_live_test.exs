defmodule PlankWeb.BoardLiveTest do
  use PlankWeb.ConnCase

  import Phoenix.LiveViewTest

  test "connected render displays board title and column", %{conn: conn} do
    %{id: id} = create_board()
    %{id: _column_id} = create_column(id)

    {:ok, page_live, _disconnected_html} = live(conn, "/boards/#{id}")
    assert render(page_live) =~ "<h1>A test project</h1>"
    assert render(page_live) =~ "<h3 class=\"panel-title\">A test column</h3>"
  end

  test "wrong board URL redirects to error", %{conn: conn} do
    assert {:error, {:redirect, %{to: "/error"}}} = live(conn, "/boards/123")
  end

  test "adds new card", %{conn: conn} do
    %{id: board_id} = create_board()
    %{id: column_id} = create_column(board_id)

    {:ok, page_live, _disconnected_html} = live(conn, "/boards/#{board_id}")

    assert page_live
           |> element("button[phx-value-column=#{column_id}]")
           |> render_click() =~ "Something new"

    assert [%{content: "Something new"}] = Plank.Repo.all(Plank.Card)
  end

  test "updating a card's content", %{conn: conn} do
    %{id: board_id} = create_board()
    %{id: column_id} = create_column(board_id)
    %{id: card_id} =
      %Plank.Card{content: "A test card", column_id: column_id}
      |> Plank.Repo.insert!()
    {:ok, page_live, _disconnected_html} = live(conn, "/boards/#{board_id}")

    assert page_live
           |> element("div[phx-value-card=#{card_id}]")
           |> render_blur(%{value: "An updated card"}) =~ "An updated card"

    assert [%{content: "An updated card"}] = Plank.Repo.all(Plank.Card)
  end

  defp create_board() do
    %Plank.Board{title: "A test project"}
    |> Plank.Repo.insert!()
  end

  defp create_column(board_id) do
    %Plank.Column{title: "A test column", board_id: board_id}
    |> Plank.Repo.insert!()
  end
end