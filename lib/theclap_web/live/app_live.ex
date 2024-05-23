defmodule TheclapWeb.App do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    total_claps = 0

    socket =
      socket
      |> assign(claps: 0)
      |> assign(total_claps: total_claps)

    {:ok, socket}
  end

  def handle_event("clap", %{"icon" => value}, socket) do
    socket =
      socket
      |> update(:claps, &(&1 + 1))
      |> push_event("client_clap", %{innerHtml: value})

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="outer h-dvh flex flex-col justify-center items-center gap-4">
      <section
        id="top"
        class="border-main p-20 border-double border-2 border-[#fcde06] rounded-full bg-green-50 text-2xl sm:text-8xl flex flex-col gap-2"
      >
        <div id="clap" phx-hook="Clap" />
        <span class="block">👏:<%= @claps %></span>
        <%!-- <span class="block">👏👏:<%= @total_claps %></span> --%>
      </section>

      <div
        id="clapper"
        phx-update="ignore"
        phx-click="clap"
        phx-value-icon="👏"
        class="border-item text-6xl p-6 border-dashed border-4 cursor-pointer border-[#fcde06] rounded-full"
      >
        👏
      </div>
    </div>
    """
  end
end
