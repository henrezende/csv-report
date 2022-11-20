defmodule CsvReportWeb.RegistrationControllerTest do
  use CsvReportWeb.ConnCase

  import CsvReport.AccountsFixtures

  alias CsvReport.Accounts.Registration

  @create_attrs %{
    cpf: "some cpf",
    email: "some email",
    name: "some name"
  }
  @update_attrs %{
    cpf: "some updated cpf",
    email: "some updated email",
    name: "some updated name"
  }
  @invalid_attrs %{cpf: nil, email: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all registrations", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create registration" do
    test "renders registration when data is valid", %{conn: conn} do
      conn = post(conn, Routes.registration_path(conn, :create), registration: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.registration_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "cpf" => "some cpf",
               "email" => "some email",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.registration_path(conn, :create), registration: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update registration" do
    setup [:create_registration]

    test "renders registration when data is valid", %{conn: conn, registration: %Registration{id: id} = registration} do
      conn = put(conn, Routes.registration_path(conn, :update, registration), registration: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.registration_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "cpf" => "some updated cpf",
               "email" => "some updated email",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, registration: registration} do
      conn = put(conn, Routes.registration_path(conn, :update, registration), registration: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete registration" do
    setup [:create_registration]

    test "deletes chosen registration", %{conn: conn, registration: registration} do
      conn = delete(conn, Routes.registration_path(conn, :delete, registration))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.registration_path(conn, :show, registration))
      end
    end
  end

  defp create_registration(_) do
    registration = registration_fixture()
    %{registration: registration}
  end
end
