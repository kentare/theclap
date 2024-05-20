defmodule TheclapWeb.ClapLive.FormComponent do
  use TheclapWeb, :live_component

  alias Theclap.Applause

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage clap records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="clap-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:value]} type="text" label="Value" />
        <.input field={@form[:user_id]} type="text" label="User" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Clap</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{clap: clap} = assigns, socket) do
    changeset = Applause.change_clap(clap)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"clap" => clap_params}, socket) do
    changeset =
      socket.assigns.clap
      |> Applause.change_clap(clap_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"clap" => clap_params}, socket) do
    save_clap(socket, socket.assigns.action, clap_params)
  end

  defp save_clap(socket, :edit, clap_params) do
    case Applause.update_clap(socket.assigns.clap, clap_params) do
      {:ok, clap} ->
        notify_parent({:saved, clap})

        {:noreply,
         socket
         |> put_flash(:info, "Clap updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_clap(socket, :new, clap_params) do
    case Applause.create_clap(clap_params) do
      {:ok, clap} ->
        notify_parent({:saved, clap})

        {:noreply,
         socket
         |> put_flash(:info, "Clap created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
