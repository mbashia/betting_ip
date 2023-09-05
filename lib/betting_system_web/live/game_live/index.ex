defmodule BettingSystemWeb.GameLive.Index do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Games
  alias BettingSystem.Games.Game
  alias BettingSystem.Accounts
  alias BettingSystem.Sports

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    sports = Sports.list_sports(user.id)

    {:ok,
     socket
     |> assign(:games, list_games())
     |> assign(:user, user)
     |>assign(:sports, sports) }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Game")
    |> assign(:game, Games.get_game!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Game")
    |> assign(:game, %Game{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Games")
    |> assign(:game, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    game = Games.get_game!(id)
    {:ok, _} = Games.delete_game(game)

    {:noreply, assign(socket, :games, list_games())}
  end

  defp list_games do
    Games.list_games()
  end
end
