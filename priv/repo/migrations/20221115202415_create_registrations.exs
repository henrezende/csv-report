defmodule CsvReport.Repo.Migrations.CreateRegistrations do
  use Ecto.Migration

  def change do
    create table(:registrations) do
      add :name, :string
      add :cpf, :string
      add :email, :string
      add :partner_id, references(:partners, on_delete: :nothing)

      timestamps()
    end

    create index(:registrations, [:partner_id])
  end
end
