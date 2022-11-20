defmodule CsvReport.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CsvReport.Accounts` context.
  """

  @doc """
  Generate a partner.
  """
  def partner_fixture(attrs \\ %{}) do
    {:ok, partner} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> CsvReport.Accounts.create_partner()

    partner
  end

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

    registration
  end
end
