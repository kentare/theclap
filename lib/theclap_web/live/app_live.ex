defmodule TheclapWeb.App do
  use Phoenix.LiveView

  @room "clap"

  def mount(_params, _session, socket) do
    total_claps = 0

    :ok = Phoenix.PubSub.subscribe(Theclap.PubSub, @room)

    socket = socket |> assign(claps: 0) |> assign(total_claps: total_claps)

    {:ok, socket}
  end

  def handle_event("clap", %{"icon" => value}, socket) do
    Phoenix.PubSub.broadcast(Theclap.PubSub, @room, {:clap, value})

    socket = socket |> update(:claps, &(&1 + 1))

    {:noreply, socket}
  end

  def handle_info({:clap, innerHtml}, socket) do
    socket =
      socket
      |> push_event("client_clap", %{innerHtml: innerHtml})
      |> update(:total_claps, &(&1 + 1))

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="h-dvh ho flex flex-col justify-center items-center gap-5">
      <section id="top" class="bg-green-50 text-2xl sm:text-8xl flex flex-col gap-2 border-main">
        <div id="clap" phx-hook="Clap" /> <span class="block">👏:<%= @claps %></span>
        <%!-- <span class="block">👏👏:<%= @total_claps %></span> --%>
      </section>
      
      <%!-- <form
        phx-submit="clap"
        phx-change="clap"
        class="flex justify-center items-center gap-2  mx-auto border-item"
      >
        <input
          id="input"
          phx-update="ignore"
          class="text-6xl w-1/2 rounded-full"
          type="text"
          name="icon"
          pattern=".{1,2}"
        />
        <button type="submit" class="text-6xl p-4">⬅️</button>
        <input
          id="range"
          type="range"
          phx-update="ignore"
          min="0"
          max="100"
          value="50"
          class="w-1/2 slider"
        />
      </form> --%>
      <%!-- <div phx-click="clap" class="border-item" phx-value-icon="😀">
        😀
      </div> --%>
      <div phx-click="clap" phx-value-icon="👏" class="border-item">
        👏
      </div>
    </div>
    """
  end
end
