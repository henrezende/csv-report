defmodule CsvReport.Accounts.Registration do
  use Ecto.Schema
  import Ecto.Changeset
  alias CsvReport.Accounts.Partner

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type :binary_id
  schema "registrations" do
    field :cpf, :string
    field :email, :string
    field :name, :string
    belongs_to :partner, Partner

    timestamps()
  end

  @doc false
  @required_fields [:name, :cpf, :email]
  def changeset(registration, attrs) do
    registration
    |> cast(attrs, @required_fields)
    |> cast_assoc(:partner)
    |> validate_required(@required_fields)
  end
end
