defmodule CsvReport.Report do
  alias CsvReport.Accounts

  def csv(report_name, filters) when report_name == "DailyRegistrations" do
    fields = [:name, :cpf, :email, :inserted_at]
    formatted_filters = get_formatted_filters(filters)
    get_daily_registration_list(formatted_filters, fields)
  end

  def csv(report_name, filters) when report_name == "DailyRegistrationsByPartner" do
    fields = [:name, :cpf, :email, :inserted_at, :partner_name]
    formatted_filters = get_formatted_filters(filters)
    get_daily_registration_list(formatted_filters, fields)
  end

  defp get_formatted_filters(filters) when is_nil(filters) do
    {:ok, %{}}
  end

  defp get_formatted_filters(filters) do
    with {:ok, parsed_start_date} <-
           Timex.parse(Map.get(filters, "start_date"), "{YYYY}-{0M}-{0D}"),
         {:ok, parsed_end_date} <-
           Timex.parse(Map.get(filters, "end_date"), "{YYYY}-{0M}-{0D}") do
      {:ok,
       %{
         "start_date" => parsed_start_date,
         "end_date" => parsed_end_date
       }}
    else
      {:error, :badarg} ->
        {:error, "Please check your filters values"}

      {:error, error} ->
        {:error, error}

      _ ->
        {:error, "Error on filters, check the correct filter format"}
    end
  end

  defp get_daily_registration_list(formatted_filters, fields) do
    case formatted_filters do
      {:ok, filters} ->
        daily_registrations =
          Accounts.list_daily_registrations(filters)
          |> Enum.map(fn record ->
            Map.merge(record, Map.take(record, fields))
          end)
          |> CSV.encode(headers: fields)
          |> Enum.to_list()

        {:ok, daily_registrations}

      {:error, error} ->
        {:error, error}
    end
  end
end
