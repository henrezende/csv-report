defmodule CsvReportWeb.PartnerController do
  use CsvReportWeb, :controller

  alias CsvReport.Accounts
  alias CsvReport.Accounts.Partner

  action_fallback CsvReportWeb.FallbackController

  def index(conn, _params) do
    partners = Accounts.list_partners()
    render(conn, "index.json", partners: partners)
  end

  def create(conn, %{"partner" => partner_params}) do
    with {:ok, %Partner{} = partner} <- Accounts.create_partner(partner_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.partner_path(conn, :show, partner))
      |> render("show.json", partner: partner)
    end
  end

  def show(conn, %{"id" => id}) do
    partner = Accounts.get_partner!(id)
    render(conn, "show.json", partner: partner)
  end

  def update(conn, %{"id" => id, "partner" => partner_params}) do
    partner = Accounts.get_partner!(id)

    with {:ok, %Partner{} = partner} <- Accounts.update_partner(partner, partner_params) do
      render(conn, "show.json", partner: partner)
    end
  end

  def delete(conn, %{"id" => id}) do
    partner = Accounts.get_partner!(id)

    with {:ok, %Partner{}} <- Accounts.delete_partner(partner) do
      send_resp(conn, :no_content, "")
    end
  end
end
