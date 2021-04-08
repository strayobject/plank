defmodule PlankWeb.BoardController do
  use PlankWeb, :controller
  import Phoenix.LiveView.Controller

  def show(conn, %{"id" => id}) do
    live_render(conn, PlankWeb.BoardLive, session: %{"board_id" => id})
  end
end