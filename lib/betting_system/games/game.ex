defmodule BettingSystem.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias BettingSystem.Accounts.User


  schema "games" do
    field :date, :naive_datetime
    field :draw, :float
    field :location, :string
    field :lose, :float
    field :result, :string
    field :status, :string
    field :type, :string
    field :win, :float
    belongs_to :user, User,foreign_key: :user_id


    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:type, :date, :status, :result, :location, :win, :draw, :lose, :user_id])
    |> validate_required([:type, :date, :status, :result, :location, :win, :draw, :lose, :user_id])
  end
end
