defmodule BosunApp.Repo.Migrations.CreateDogs do
  use Ecto.Migration

  def change do
    create table(:dogs) do
      add :name, :string

      timestamps()
    end
  end
end
