defmodule Theclap.ApplauseTest do
  use Theclap.DataCase

  alias Theclap.Applause

  describe "claps" do
    alias Theclap.Applause.Clap

    import Theclap.ApplauseFixtures

    @invalid_attrs %{value: nil, user_id: nil}

    test "list_claps/0 returns all claps" do
      clap = clap_fixture()
      assert Applause.list_claps() == [clap]
    end

    test "get_clap!/1 returns the clap with given id" do
      clap = clap_fixture()
      assert Applause.get_clap!(clap.id) == clap
    end

    test "create_clap/1 with valid data creates a clap" do
      valid_attrs = %{value: "some value", user_id: "some user_id"}

      assert {:ok, %Clap{} = clap} = Applause.create_clap(valid_attrs)
      assert clap.value == "some value"
      assert clap.user_id == "some user_id"
    end

    test "create_clap/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Applause.create_clap(@invalid_attrs)
    end

    test "update_clap/2 with valid data updates the clap" do
      clap = clap_fixture()
      update_attrs = %{value: "some updated value", user_id: "some updated user_id"}

      assert {:ok, %Clap{} = clap} = Applause.update_clap(clap, update_attrs)
      assert clap.value == "some updated value"
      assert clap.user_id == "some updated user_id"
    end

    test "update_clap/2 with invalid data returns error changeset" do
      clap = clap_fixture()
      assert {:error, %Ecto.Changeset{}} = Applause.update_clap(clap, @invalid_attrs)
      assert clap == Applause.get_clap!(clap.id)
    end

    test "delete_clap/1 deletes the clap" do
      clap = clap_fixture()
      assert {:ok, %Clap{}} = Applause.delete_clap(clap)
      assert_raise Ecto.NoResultsError, fn -> Applause.get_clap!(clap.id) end
    end

    test "change_clap/1 returns a clap changeset" do
      clap = clap_fixture()
      assert %Ecto.Changeset{} = Applause.change_clap(clap)
    end
  end
end
