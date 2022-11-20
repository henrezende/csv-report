# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CsvReport.Repo.insert!(%CsvReport.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CsvReport.Repo
alias CsvReport.Accounts.Partner
alias CsvReport.Accounts.Registration

Repo.delete_all(Partner)
Repo.delete_all(Registration)

for item <- 1..30 do
  partner =
    Repo.insert!(%Partner{
      name: "Partner #{item}"
    })

  for item_reg <- 1..10 do
    Repo.insert!(%Registration{
      name: "Partner #{item}#{item_reg}",
      cpf: Integer.to_string(item + item_reg) |> String.pad_leading(10, "0"),
      email: "registration#{item}#{item_reg}@email.com",
      partner_id: partner.id
    })
  end
end
