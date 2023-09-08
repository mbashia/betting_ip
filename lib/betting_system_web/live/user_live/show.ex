defmodule BettingSystemWeb.UserLive.Show do
  use BettingSystemWeb, :live_view

  alias BettingSystem.Betslips

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:betslips, Betslips.get_betslip_user_id(id))}
  end

  defp page_title(:show), do: "Show user"
  defp page_title(:edit), do: "Edit Sport"
end
