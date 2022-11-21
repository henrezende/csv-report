defmodule CsvReport.AccountsTest do
  use CsvReport.DataCase

  alias CsvReport.Accounts

  describe "registrations" do
    import CsvReport.AccountsFixtures

    test "list_daily_registrations with no filters returns all registrations" do
      registration = registration_fixture()
      list_daily_registrations = Accounts.list_daily_registrations(%{})
      assert List.first(list_daily_registrations).cpf == registration.cpf
    end

    test "list_daily_registrations with filters returns all registrations within range" do
      registration = registration_fixture()

      filters = %{
        "start_date" => Timex.now(),
        "end_date" => Timex.now() |> Timex.shift(days: 1)
      }

      list_daily_registrations = Accounts.list_daily_registrations(filters)
      assert List.first(list_daily_registrations).cpf == registration.cpf
    end
  end
end
