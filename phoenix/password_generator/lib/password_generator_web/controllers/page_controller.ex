defmodule PasswordGeneratorWeb.PageController do
  use PasswordGeneratorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
