defmodule BettingSystem.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :type, :string
      add :date, :naive_datetime
      add :status, :string
      add :result, :string
      add :location, :string
      add :win, :float
      add :draw, :float
      add :lose, :float
      add :user_id, :integer

      timestamps()
    end
    create index(:games, [:user_id])
  end
end
