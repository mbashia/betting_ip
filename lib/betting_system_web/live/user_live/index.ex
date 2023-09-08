defmodule BettingSystemWeb.UserLive.Index do
  use BettingSystemWeb, :live_view
  alias BettingSystem.Users
  alias BettingSystem.Games
  alias BettingSystem.Bet
  alias BettingSystem.Accounts.User
  alias BettingSystem.Accounts
  alias BettingSystem.Repo

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"]) |> Repo.preload(:betslips)
    users = Users.list_users()
    user_bets = Bet.get_all_bets(user.id)

    Enum.each(user_bets, fn bet ->
      bet_items = bet.bet_items
      game_ids = Map.values(bet_items)

      Enum.each(game_ids, fn game_id ->
        game = Games.get_game!(game_id)

        IO.inspect(game)
      end)
    end)

    {:ok,
     socket
     |> assign(:users, users)
     |> assign(:current_user, user)
     |> assign(:check_bet_history, 0)
     |> assign(:bets, user_bets)
    }
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit user")
    |> assign(:user, Users.get_user!(id))
  end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New user")
  #   |> assign(:user, %User{})
  # end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing users")
    |> assign(:sport, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Users.get_user!(id)
    cond do
      user.status == "active" ->
        case Users.update_user(user, %{status: "inactive"}) do
          {:ok, _user} ->
           {:noreply,
           socket
            |> put_flash(:info, "User deactivated successfully")
          }
          {:error, _changeset} ->
            {:noreply,
            socket
            |> put_flash(:error, "Failed to deactivate user")}
        end

      user.status == "inactive" ->
        case Users.update_user(user, %{status: "active"}) do
          {:ok, _user} ->
            {:noreply,
            socket
            |> put_flash(:info, "User activated successfully")
          }
          {:error, _changeset} ->
            {:noreply,
            socket
            |> put_flash(:error, "Failed to activate user:")}
        end

      true ->
        socket
        |> put_flash(:error, "Invalid user status")
    end
    # {:ok, _} = Users.delete_user(users)

    # {:noreply, assign(socket, :users, Users.list_users())}
  end

  def handle_event("bet history", params, socket) do
    {:noreply,
     socket
     |> assign(:check_bet_history, 1)}
  end
end
