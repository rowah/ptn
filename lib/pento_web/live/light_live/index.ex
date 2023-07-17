defmodule PentoWeb.LightLive.Index do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, :brightness, 10)
    }
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

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
