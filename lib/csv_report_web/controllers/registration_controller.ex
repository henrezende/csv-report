defmodule CsvReportWeb.RegistrationController do
  use CsvReportWeb, :controller

  alias CsvReport.Accounts
  alias CsvReport.Accounts.Registration

  action_fallback CsvReportWeb.FallbackController

  def index(conn, _params) do
    registrations = Accounts.list_registrations()
    render(conn, "index.json", registrations: registrations)
  end

  def create(conn, %{"registration" => registration_params}) do
    with {:ok, %Registration{} = registration} <- Accounts.create_registration(registration_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.registration_path(conn, :show, registration))
      |> render("show.json", registration: registration)
    end
  end

  def show(conn, %{"id" => id}) do
    registration = Accounts.get_registration!(id)
    render(conn, "show.json", registration: registration)
  end

  def update(conn, %{"id" => id, "registration" => registration_params}) do
    registration = Accounts.get_registration!(id)

    with {:ok, %Registration{} = registration} <- Accounts.update_registration(registration, registration_params) do
      render(conn, "show.json", registration: registration)
    end
  end

  def delete(conn, %{"id" => id}) do
    registration = Accounts.get_registration!(id)

    with {:ok, %Registration{}} <- Accounts.delete_registration(registration) do
      send_resp(conn, :no_content, "")
    end
  end
end
