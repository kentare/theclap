defmodule TheclapWeb.ClapLiveTest do
  use TheclapWeb.ConnCase

  import Phoenix.LiveViewTest
  import Theclap.ApplauseFixtures

  @create_attrs %{value: "some value", user_id: "some user_id"}
  @update_attrs %{value: "some updated value", user_id: "some updated user_id"}
  @invalid_attrs %{value: nil, user_id: nil}

  defp create_clap(_) do
    clap = clap_fixture()
    %{clap: clap}
  end

  describe "Index" do
    setup [:create_clap]

    test "lists all claps", %{conn: conn, clap: clap} do
      {:ok, _index_live, html} = live(conn, ~p"/claps")

      assert html =~ "Listing Claps"
      assert html =~ clap.value
    end

    test "saves new clap", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/claps")

      assert index_live |> element("a", "New Clap") |> render_click() =~
               "New Clap"

      assert_patch(index_live, ~p"/claps/new")

      assert index_live
             |> form("#clap-form", clap: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#clap-form", clap: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/claps")

      html = render(index_live)
      assert html =~ "Clap created successfully"
      assert html =~ "some value"
    end

    test "updates clap in listing", %{conn: conn, clap: clap} do
      {:ok, index_live, _html} = live(conn, ~p"/claps")

      assert index_live |> element("#claps-#{clap.id} a", "Edit") |> render_click() =~
               "Edit Clap"

      assert_patch(index_live, ~p"/claps/#{clap}/edit")

      assert index_live
             |> form("#clap-form", clap: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#clap-form", clap: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/claps")

      html = render(index_live)
      assert html =~ "Clap updated successfully"
      assert html =~ "some updated value"
    end

    test "deletes clap in listing", %{conn: conn, clap: clap} do
      {:ok, index_live, _html} = live(conn, ~p"/claps")

      assert index_live |> element("#claps-#{clap.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#claps-#{clap.id}")
    end
  end

  describe "Show" do
    setup [:create_clap]

    test "displays clap", %{conn: conn, clap: clap} do
      {:ok, _show_live, html} = live(conn, ~p"/claps/#{clap}")

      assert html =~ "Show Clap"
      assert html =~ clap.value
    end

    test "updates clap within modal", %{conn: conn, clap: clap} do
      {:ok, show_live, _html} = live(conn, ~p"/claps/#{clap}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Clap"

      assert_patch(show_live, ~p"/claps/#{clap}/show/edit")

      assert show_live
             |> form("#clap-form", clap: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#clap-form", clap: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/claps/#{clap}")

      html = render(show_live)
      assert html =~ "Clap updated successfully"
      assert html =~ "some updated value"
    end
  end
end
