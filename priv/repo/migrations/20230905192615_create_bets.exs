defmodule BettingSystem.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :amount, :float
      add :outcome, :string
      add :odds, :float
      add :status, :string
      add :payout, :float
      add :user_id, :integer

      timestamps()
    end
    create index(:bets, [:user_id])

  end
end
