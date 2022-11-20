defmodule CsvReport.Accounts.Partner do
  use Ecto.Schema
  import Ecto.Changeset
  alias CsvReport.Accounts.Registration

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "partners" do
    field :name, :string
    has_many :registration, Registration

    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
