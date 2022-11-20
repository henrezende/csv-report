defmodule CsvReport.Report do
  alias CsvReport.Accounts

  def csv(report_name, filters) when report_name == "DailyRegistrations" do
    fields = [:name, :cpf, :email, :inserted_at]

    formatted_filters = get_formatted_filters(filters)

    case formatted_filters do
      {:ok, filters} ->
        daily_registrations =
          Accounts.list_daily_registrations(filters)
          |> Enum.map(fn record ->
            record
            |> Map.from_struct()
            |> Map.take([])
            |> Map.merge(Map.take(record, fields))
          end)
          |> CSV.encode(headers: fields)
          |> Enum.to_list()
          |> to_string()

        {:ok, daily_registrations}

      {:error, error} ->
        {:error, error}
    end
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

  @doc """
  Gets the content of a csv file with registrations data.

  ## Examples

      iex> get_registrations_csv_content([:name, :cpf])
      "name,cpf\r\nPartner 1,0000000001\r\nPartner 2,0000000002"

      iex> create_regiget_registrations_csv_contentstration([])
      ""

  """
  # defp get_registrations_csv_content(report_name, filters) do
  #   fields = [:name, :cpf, :email, :partner_id, :inserted_at]

  #   Accounts.list_registrations()
  #   |> Enum.map(fn record ->
  #     record
  #     |> Map.from_struct()
  #     |> Map.take([])
  #     |> Map.merge(Map.take(record, fields))
  #   end)
  #   |> CSV.encode(headers: fields)
  #   |> Enum.to_list()
  #   |> to_string()
  # end
end
