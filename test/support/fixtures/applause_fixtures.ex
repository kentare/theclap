defmodule Theclap.ApplauseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Theclap.Applause` context.
  """

  @doc """
  Generate a clap.
  """
  def clap_fixture(attrs \\ %{}) do
    {:ok, clap} =
      attrs
      |> Enum.into(%{
        user_id: "some user_id",
        value: "some value"
      })
      |> Theclap.Applause.create_clap()

    clap
  end
end
