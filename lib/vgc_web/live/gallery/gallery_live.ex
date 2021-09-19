defmodule VgcWeb.GalleryLive do
  use Phoenix.LiveView
  alias Vgc.Gallery

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:current_id, Gallery.first_id())
      |> assign(:slideshow, :stopped)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <img src="<%= Gallery.image_url(@current_id) %>" style="max-height: 600px" class="mx-auto">
    <div class="flex justify-between">
      <button class="mx-auto lg:mx-0 uppercase hover:underline gradient text-white font-bold rounded-full my-6 py-4 px-8 shadow-lg focus:outline-none focus:shadow-outline transform transition hover:scale-105 duration-300 ease-in-out" phx-click="prev">Prev</button>
      <button class="mx-auto lg:mx-0 uppercase hover:underline gradient text-white font-bold rounded-full my-6 py-4 px-8 shadow-lg focus:outline-none focus:shadow-outline transform transition hover:scale-105 duration-300 ease-in-out" phx-click="next">Next</button>
    </div>
    <div class="flex mt-4 justify-between invisible sm:visible">
      <%= for id <- Gallery.image_ids() do %>
        <img src="<%= Gallery.image_url(id) %>"
          class="<%= thumb_css_class(id, @current_id) %> max-h-40">
      <% end %>
    </div>
    """
  end

  def handle_event("play_slideshow", _, socket) do
    {:ok, ref} = :timer.send_interval(1_000, self(), :slideshow_next)
    {:noreply, assign(socket, :slideshow, ref)}
  end

  def handle_event("stop_slideshow", _, socket) do
    :timer.cancel(socket.assigns.slideshow)
    {:noreply, assign(socket, :slideshow, :stopped)}
  end

  def handle_info(:slideshow_next, socket) do
    {:noreply, assign_next_id(socket)}
  end

  def handle_event("prev", _, socket) do
    {:noreply, assign_prev_id(socket)}
  end

  def handle_event("next", _, socket) do
    {:noreply, assign_next_id(socket)}
  end

  def assign_prev_id(socket) do
    assign(socket, :current_id, Gallery.prev_image_id(socket.assigns.current_id))
  end

  def assign_next_id(socket) do
    assign(socket, :current_id, Gallery.next_image_id(socket.assigns.current_id))
  end

  def thumb_css_class(thumb_id, current_id) do
    if thumb_id == current_id do
      "thumb-selected"
    else
      "thumb-unselected"
    end
  end
end
