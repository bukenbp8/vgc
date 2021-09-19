defmodule VgcWeb.PageController do
  use VgcWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
