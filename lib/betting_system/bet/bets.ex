defmodule BettingSystem.Bet.Bets do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bets" do
    field :amount, :float
    field :odds, :float
    field :outcome, :string
    field :payout, :float
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(bets, attrs) do
    bets
    |> cast(attrs, [:amount, :outcome, :odds, :status, :payout])
    |> validate_required([:amount, :outcome, :odds, :status, :payout])
  end
end
