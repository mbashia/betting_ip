defmodule BettingSystem.Bet.Bets do
  use Ecto.Schema
  import Ecto.Changeset
  alias BettingSystem.Accounts.User

  schema "bets" do
    field :amount, :float
    field :odds, :float
    field :payout, :float
    field :status, :string
    belongs_to :user, User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(bets, attrs) do
    bets
    |> cast(attrs, [:amount,  :odds, :status, :payout, :user_id])
    |> validate_required([:amount,  :odds, :status, :payout, :user_id])
  end
end
