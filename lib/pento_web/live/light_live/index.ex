defmodule PentoWeb.LightLive.Index do
  use PentoWeb, :live_view

  # Mount callback - Called when the LiveView is being mounted
  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, :brightness, 10)
    }
  end

  # Handle_event callback - Called when an event is triggered from the client
  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  # Render callback - Called to generate the LiveView's HTML (can be inside the module or in a different .heex file)
  # def render(assigns) do
  #   ~H"""
  #   Light: <%= @brightness %>
  #   <br/>
  #   <br>
  #   <button phx-click="off">Off</button>
  #   <button phx-click="on">On</button>
  #   """
  # end
end
