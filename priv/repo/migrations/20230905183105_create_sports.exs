defmodule BettingSystem.Repo.Migrations.CreateSports do
  use Ecto.Migration

  def change do
    create table(:sports) do
      add :name, :string
      add :description, :string
      add :active, :string

      timestamps()
    end
  end
end
