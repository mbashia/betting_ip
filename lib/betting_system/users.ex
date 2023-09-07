defmodule BettingSystem.Users do
  import Ecto.Query, warn: false
  alias BettingSystem.Repo

  alias BettingSystem.Accounts.User


  def list_users()do
    Repo.all(User)
  end

end
