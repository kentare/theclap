defmodule Theclap.Applause.Clap do
  use Ecto.Schema
  import Ecto.Changeset

  schema "claps" do
    field :value, :string
    field :user_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(clap, attrs) do
    clap
    |> cast(attrs, [:value, :user_id])
    |> validate_required([:value, :user_id])
  end
end
