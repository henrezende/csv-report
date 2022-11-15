defmodule CsvReport.Repo do
  use Ecto.Repo,
    otp_app: :csv_report,
    adapter: Ecto.Adapters.Postgres
end
