defmodule CsvReport.AccountsTest do
  use CsvReport.DataCase

  alias CsvReport.Accounts

  describe "partners" do
    alias CsvReport.Accounts.Partner

    import CsvReport.AccountsFixtures

    @invalid_attrs %{name: nil}

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Accounts.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Accounts.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Partner{} = partner} = Accounts.create_partner(valid_attrs)
      assert partner.name == "some name"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Partner{} = partner} = Accounts.update_partner(partner, update_attrs)
      assert partner.name == "some updated name"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_partner(partner, @invalid_attrs)
      assert partner == Accounts.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Accounts.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Accounts.change_partner(partner)
    end
  end

  describe "registrations" do
    alias CsvReport.Accounts.Registration

    import CsvReport.AccountsFixtures

    @invalid_attrs %{cpf: nil, email: nil, name: nil}

    test "list_registrations/0 returns all registrations" do
      registration = registration_fixture()
      assert Accounts.list_registrations() == [registration]
    end

    test "get_registration!/1 returns the registration with given id" do
      registration = registration_fixture()
      assert Accounts.get_registration!(registration.id) == registration
    end

    test "create_registration/1 with valid data creates a registration" do
      valid_attrs = %{cpf: "some cpf", email: "some email", name: "some name"}

      assert {:ok, %Registration{} = registration} = Accounts.create_registration(valid_attrs)
      assert registration.cpf == "some cpf"
      assert registration.email == "some email"
      assert registration.name == "some name"
    end

    test "create_registration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_registration(@invalid_attrs)
    end

    test "update_registration/2 with valid data updates the registration" do
      registration = registration_fixture()
      update_attrs = %{cpf: "some updated cpf", email: "some updated email", name: "some updated name"}

      assert {:ok, %Registration{} = registration} = Accounts.update_registration(registration, update_attrs)
      assert registration.cpf == "some updated cpf"
      assert registration.email == "some updated email"
      assert registration.name == "some updated name"
    end

    test "update_registration/2 with invalid data returns error changeset" do
      registration = registration_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_registration(registration, @invalid_attrs)
      assert registration == Accounts.get_registration!(registration.id)
    end

    test "delete_registration/1 deletes the registration" do
      registration = registration_fixture()
      assert {:ok, %Registration{}} = Accounts.delete_registration(registration)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_registration!(registration.id) end
    end

    test "change_registration/1 returns a registration changeset" do
      registration = registration_fixture()
      assert %Ecto.Changeset{} = Accounts.change_registration(registration)
    end
  end
end
