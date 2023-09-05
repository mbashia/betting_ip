defmodule BettingSystem.Sports.Sport do
  use Ecto.Schema
  import Ecto.Changeset
  alias BettingSystem.Accounts.User


  schema "sports" do
    field :description, :string
    field :name, :string
    field :active, :string
    belongs_to :user, User,foreign_key: :user_id


    timestamps()
  end

  @doc false
  def changeset(sport, attrs) do
    sport
    |> cast(attrs, [:name, :description,:active,:user_id])
    |> validate_required([:name, :description,:active,:user_id])
  end
end
