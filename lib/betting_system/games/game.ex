defmodule BettingSystem.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :date, :naive_datetime
    field :draw, :float
    field :location, :string
    field :lose, :float
    field :result, :string
    field :status, :string
    field :type, :string
    field :win, :float

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:type, :date, :status, :result, :location, :win, :draw, :lose])
    |> validate_required([:type, :date, :status, :result, :location, :win, :draw, :lose])
  end
end
