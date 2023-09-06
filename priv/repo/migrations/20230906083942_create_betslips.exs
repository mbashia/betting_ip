defmodule BettingSystem.Repo.Migrations.CreateBetslips do
  use Ecto.Migration

  def change do
    create table(:betslips) do
      add :status, :string
      add :odds, :float
      add :result_type, :string
      add :game_id, :integer
      add :user_id, :integer

      timestamps()
    end
  end
end
