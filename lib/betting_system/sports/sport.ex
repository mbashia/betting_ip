defmodule BettingSystem.Sports.Sport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sports" do
    field :description, :string
    field :name, :string
    field :active, :string

    timestamps()
  end

  @doc false
  def changeset(sport, attrs) do
    sport
    |> cast(attrs, [:name, :description,:active])
    |> validate_required([:name, :description,:active])
  end
end
