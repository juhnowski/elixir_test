defmodule PasswordGeneratorWeb.Api.PageControllerTest do
  use PasswordGeneratorWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "generates a password" do
    test "generates password with only length passed", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{"length" => "5"})
      assert %{"password" => _pass} = json_response(conn, 200)
    end

    test "generates password with one option", %{conn: conn} do
      options = %{"length" => "5", "numbers" => "true"}
      conn = post(conn, Routes.page_path(conn, :api_generate), options)
      assert %{"password" => _pass} = json_response(conn, 200)
    end
  end

  describe "return errors" do
    test "error when no options", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{})
      assert %{"error" => _err} = json_response(conn, 200)
    end

    test "error when length not integer", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{"length" => "ab"})
      assert %{"error" => _err} = json_response(conn, 200)
    end

    test "error when options not booleans", %{conn: conn} do
      conn =
        post(conn, Routes.page_path(conn, :api_generate), %{
          "length" => "ab",
          "invalid" => "invalid"
        })

      assert %{"error" => _err} = json_response(conn, 200)
    end

    test "error when not valid options", %{conn: conn} do
      conn =
        post(conn, Routes.page_path(conn, :api_generate), %{
          "length" => "5",
          "invalid" => "true"
        })

      assert %{"error" => _err} = json_response(conn, 200)
    end
  end
end
