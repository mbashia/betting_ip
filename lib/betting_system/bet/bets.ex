defmodule BettingSystem.Bet.Bets do
  use Ecto.Schema
  import Ecto.Changeset
  alias BettingSystem.Accounts.User

  schema "bets" do
    field :amount, :integer
    field :odds, :float
    field :payout, :float, default: 0.0
    field :status, :string, default: "open"
    field :bet_items, {:map, :integer}
    field :bet_id, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(bets, attrs) do
    bets
    |> cast(attrs, [:amount, :odds, :status, :payout, :user_id, :bet_items, :bet_id])
    |> validate_required([:amount, :odds, :status, :payout, :user_id, :bet_items, :bet_id])
  end
end
