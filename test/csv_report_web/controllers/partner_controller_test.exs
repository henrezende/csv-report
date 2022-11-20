defmodule CsvReportWeb.PartnerControllerTest do
  use CsvReportWeb.ConnCase

  import CsvReport.AccountsFixtures

  alias CsvReport.Accounts.Partner

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all partners", %{conn: conn} do
      conn = get(conn, Routes.partner_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create partner" do
    test "renders partner when data is valid", %{conn: conn} do
      conn = post(conn, Routes.partner_path(conn, :create), partner: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.partner_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.partner_path(conn, :create), partner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update partner" do
    setup [:create_partner]

    test "renders partner when data is valid", %{conn: conn, partner: %Partner{id: id} = partner} do
      conn = put(conn, Routes.partner_path(conn, :update, partner), partner: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.partner_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, partner: partner} do
      conn = put(conn, Routes.partner_path(conn, :update, partner), partner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete partner" do
    setup [:create_partner]

    test "deletes chosen partner", %{conn: conn, partner: partner} do
      conn = delete(conn, Routes.partner_path(conn, :delete, partner))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.partner_path(conn, :show, partner))
      end
    end
  end

  defp create_partner(_) do
    partner = partner_fixture()
    %{partner: partner}
  end
end
