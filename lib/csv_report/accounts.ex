defmodule CsvReport.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias CsvReport.Repo

  alias CsvReport.Accounts.Partner
  alias CsvReport.Accounts.Registration

  @doc """
  Creates a partner.

  ## Examples

      iex> create_partner(%{field: value})
      {:ok, %Partner{}}

      iex> create_partner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_partner(attrs \\ %{}) do
    %Partner{}
    |> Partner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of registrations.

  ## Examples

      iex> list_daily_registrations(filters)
      [%{}, ...]

  """
  def list_daily_registrations(filters) when filters == %{} do
    Registration
    |> join(:left, [reg], partner in assoc(reg, :partner))
    |> select([reg, partner], %{
      cpf: reg.cpf,
      email: reg.email,
      name: reg.name,
      inserted_at: reg.inserted_at,
      partner_name: partner.name
    })
    |> Repo.all()
  end

  def list_daily_registrations(filters) do
    Registration
    |> where([reg], reg.inserted_at >= ^filters["start_date"])
    |> where([reg], reg.inserted_at <= ^filters["end_date"])
    |> join(:left, [reg], partner in assoc(reg, :partner))
    |> select([reg, partner], %{
      cpf: reg.cpf,
      email: reg.email,
      name: reg.name,
      inserted_at: reg.inserted_at,
      partner_name: partner.name
    })
    |> Repo.all()
  end

  @doc """
  Creates a registration.

  ## Examples

      iex> create_registration(%{field: value})
      {:ok, %Registration{}}

      iex> create_registration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_registration(attrs \\ %{}) do
    %Registration{}
    |> Registration.changeset(attrs)
    |> Repo.insert()
  end
end
