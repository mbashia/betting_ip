defmodule BettingSystem.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias BettingSystem.Accounts.User
  alias BettingSystem.Sports.Sport

  schema "games" do
    field :date, :naive_datetime
    field :draw, :float
    field :location, :string
    field :lose, :float
    field :result, :string
    field :status, :string
    field :teams, :string
    # field :type, :string
    field :win, :float
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :sport, Sport, foreign_key: :sport_id

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [ :date, :status, :result, :location, :win, :draw, :lose, :user_id, :sport_id, :teams])
    |> validate_required([ :date, :status, :result, :location, :win, :draw, :lose, :user_id, :sport_id, :teams])
  end
end
