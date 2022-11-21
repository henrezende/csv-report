defmodule CsvReport.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CsvReport.Accounts` context.
  """

  @doc """
  Generate a registration.
  """
  def registration_fixture(attrs \\ %{}) do
    {:ok, registration} =
      attrs
      |> Enum.into(%{
        cpf: "some cpf",
        email: "some email",
        name: "some name"
      })
      |> CsvReport.Accounts.create_registration()

    %{
      cpf: registration.cpf,
      email: registration.email,
      name: registration.name,
      inserted_at: registration.inserted_at
    }
  end
end
