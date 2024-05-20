defmodule TheclapWeb.ClapLive.Show do
  use TheclapWeb, :live_view

  alias Theclap.Applause

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:clap, Applause.get_clap!(id))}
  end

  defp page_title(:show), do: "Show Clap"
  defp page_title(:edit), do: "Edit Clap"
end
