defmodule CsvReportWeb.CsvReportControllerTest do
  use CsvReportWeb.ConnCase
  import CsvReport.AccountsFixtures

  describe "create csv" do
    test "creates csv when filters are valid", %{conn: conn} do
      registration = registration_fixture()

      valid_filters = %{
        "start_date" => Timex.now() |> Timex.format!("{YYYY}-{0M}-{D}"),
        "end_date" => Timex.now() |> Timex.shift(days: 1) |> Timex.format!("{YYYY}-{0M}-{D}")
      }

      conn =
        post(conn, Routes.csv_report_path(conn, :create, "DailyRegistrations"),
          filters: valid_filters
        )

      assert String.contains?(response(conn, 200), registration.name)

      conn =
        post(conn, Routes.csv_report_path(conn, :create, "DailyRegistrationsByPartner"),
          filters: valid_filters
        )

      assert String.contains?(response(conn, 200), registration.name)
    end

    test "creates csv without filters", %{conn: conn} do
      registration = registration_fixture()

      conn = post(conn, Routes.csv_report_path(conn, :create, "DailyRegistrations"))

      assert String.contains?(response(conn, 200), registration.name)

      conn = post(conn, Routes.csv_report_path(conn, :create, "DailyRegistrationsByPartner"))

      assert String.contains?(response(conn, 200), registration.name)
    end

    test "creates csv fails when filters are invalid", %{conn: conn} do
      invalid_filters = %{
        "start_date" => Timex.now() |> Timex.format!("{YYYY}-{0M}-{D}")
      }

      conn =
        post(conn, Routes.csv_report_path(conn, :create, "DailyRegistrations"),
          filters: invalid_filters
        )

      assert response(conn, 500) == "Please check your filters values"

      conn =
        post(conn, Routes.csv_report_path(conn, :create, "DailyRegistrationsByPartner"),
          filters: invalid_filters
        )

      assert response(conn, 500) == "Please check your filters values"
    end

    test "creates csv fails when filters are in a wrong format", %{conn: conn} do
      invalid_filters = %{
        "start_date" => "20221120",
        "end_date" => "20221120"
      }

      conn =
        post(conn, Routes.csv_report_path(conn, :create, "DailyRegistrations"),
          filters: invalid_filters
        )

      assert response(conn, 500)

      conn =
        post(conn, Routes.csv_report_path(conn, :create, "DailyRegistrationsByPartner"),
          filters: invalid_filters
        )

      assert response(conn, 500)
    end
  end
end
