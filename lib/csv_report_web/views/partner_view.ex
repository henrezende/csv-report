defmodule CsvReportWeb.PartnerView do
  use CsvReportWeb, :view
  alias CsvReportWeb.PartnerView

  def render("index.json", %{partners: partners}) do
    %{data: render_many(partners, PartnerView, "partner.json")}
  end

  def render("show.json", %{partner: partner}) do
    %{data: render_one(partner, PartnerView, "partner.json")}
  end

  def render("partner.json", %{partner: partner}) do
    %{
      id: partner.id,
      name: partner.name
    }
  end
end
