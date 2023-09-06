defmodule BettingSystemWeb.GameLive.Index do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Games
  alias BettingSystem.Games.Game
  alias BettingSystem.Accounts
  alias BettingSystem.Sports
  alias BettingSystem.Betslips

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

  def handle_event("add bet",%{ "odds" =>odds,"id" => id, "type" => type,"value"=> ""}, socket ) do
game_id = String.to_integer(id)
IO.inspect(game_id)
game_odds= String.to_float(odds)
IO.inspect(game_odds)
    user_id = socket.assigns.user.id
    betslip_params = %{
 "user_id"=>user_id,
 "game_id" => game_id,
 "odds"=> game_odds,
 "status"=> "inactive",
 "result_type" => type,



    }
    case Betslips.create_betslip(betslip_params) do
      {:ok, _betslip} ->
        {:noreply,
         socket
         |> put_flash(:info, "Betslip created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
    end

  defp list_games do
    Games.list_games()
  end
end
