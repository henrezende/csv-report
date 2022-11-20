defmodule CsvReport.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias CsvReport.Repo

  alias CsvReport.Accounts.Partner
  alias CsvReport.Accounts.Registration

  @doc """
  Returns the list of partners.

  ## Examples

      iex> list_partners()
      [%Partner{}, ...]

  """
  def list_partners do
    Repo.all(Partner)
  end

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

      iex> list_registrations()
      [%Registration{}, ...]

  """
  def list_daily_registrations(filters) when filters == %{} do
    Repo.all(from r in Registration, preload: [:partner])
  end

  def list_daily_registrations(filters) do
    Registration
    |> where([q], q.inserted_at >= ^filters["start_date"])
    |> where([q], q.inserted_at <= ^filters["end_date"])
    |> preload([:partner])
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
