defmodule BettingSystem.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :amount, :float
      add :outcome, :string
      add :odds, :float
      add :status, :string
      add :payout, :float

      timestamps()
    end
  end
end
