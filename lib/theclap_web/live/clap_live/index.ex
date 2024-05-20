defmodule TheclapWeb.ClapLive.Index do
  use TheclapWeb, :live_view

  alias Theclap.Applause
  alias Theclap.Applause.Clap

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :claps, Applause.list_claps())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Clap")
    |> assign(:clap, Applause.get_clap!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Clap")
    |> assign(:clap, %Clap{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Claps")
    |> assign(:clap, nil)
  end

  @impl true
  def handle_info({TheclapWeb.ClapLive.FormComponent, {:saved, clap}}, socket) do
    {:noreply, stream_insert(socket, :claps, clap)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    clap = Applause.get_clap!(id)
    {:ok, _} = Applause.delete_clap(clap)

    {:noreply, stream_delete(socket, :claps, clap)}
  end
end
