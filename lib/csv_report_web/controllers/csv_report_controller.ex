defmodule CsvReportWeb.CsvReportController do
  use CsvReportWeb, :controller

  alias CsvReport.Report

  def create(conn, %{"report_name" => report_name} = params) do
    filters = Map.get(params, "filters")
    csv_content = Report.csv(report_name, filters)

    case csv_content do
      {:ok, csv} ->
        date = Date.to_iso8601(Date.utc_today())

        conn
        |> put_resp_content_type("text/csv")
        |> put_resp_header("content-disposition", "attachment; filename=\"#{date}_report.csv\"")
        |> put_root_layout(false)
        |> send_resp(200, csv)

      {:error, error} ->
        conn
        |> send_resp(500, error)
    end
  end
end
