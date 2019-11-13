defmodule ParkingAppWeb.PageController do
  use ParkingAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
