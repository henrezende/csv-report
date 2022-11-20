defmodule CsvReportWeb.RegistrationView do
  use CsvReportWeb, :view
  alias CsvReportWeb.RegistrationView

  def render("index.json", %{registrations: registrations}) do
    %{data: render_many(registrations, RegistrationView, "registration.json")}
  end

  def render("show.json", %{registration: registration}) do
    %{data: render_one(registration, RegistrationView, "registration.json")}
  end

  def render("registration.json", %{registration: registration}) do
    %{
      id: registration.id,
      name: registration.name,
      cpf: registration.cpf,
      email: registration.email
    }
  end
end
