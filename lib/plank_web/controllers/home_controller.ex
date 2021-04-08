defmodule PlankWeb.HomeController do
  use PlankWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end