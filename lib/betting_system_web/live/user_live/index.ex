defmodule BettingSystemWeb.UserLive.Index do
  use BettingSystemWeb, :live_view
  alias BettingSystem.Users

  def mount(_params,_session, socket)do

users = Users.list_users()
    {:ok, socket
              |>assign(:users, users )}

  end
end
