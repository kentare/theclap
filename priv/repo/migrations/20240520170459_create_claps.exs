defmodule Theclap.Repo.Migrations.CreateClaps do
  use Ecto.Migration

  def change do
    create table(:claps) do
      add :value, :string
      add :user_id, :string

      timestamps(type: :utc_datetime)
    end
  end
end
