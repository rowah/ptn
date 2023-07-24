defmodule PentoWeb.WrongLive.Wrong do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    {
      :ok,
      socket
      |> assign(score: 0, number_to_guess: 8, message: "Guess a number")
      |> assign(current_time: get_current_time())
      |> assign(
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  defp get_current_time() do
    DateTime.utc_now() |> DateTime.to_iso8601()
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(data)

    number_to_guess = socket.assigns.number_to_guess

    if String.to_integer(guess) == number_to_guess do
      message = "Congrats! Your guess #{guess} is correct"
      score = socket.assigns.score + 1

      # transform the data within socket.assigns
      {
        :noreply,
        assign(
          socket,
          score: score,
          message: message,
          current_time: get_current_time()
        )
      }
    else
      message = "Your guess is: #{guess}. Wrong guess!! Guess again."
      score = socket.assigns.score - 1

      # transform the data within socket.assigns
      {
        :noreply,
        assign(
          socket,
          score: score,
          message: message,
          current_time: get_current_time()
        )
      }
    end
  end

  def render(assigns) do
    ~L"""
      <h1>Your score: <%= @score %></h1>
      <h2>
        <%= @message %>
        It's <%= @current_time %>
      </h2>
      <h2>
        <%= for n <- 1..10 do %>
          <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
        <% end %>
    </h2>
    <pre>
    <%= @user.email %>
    <%= @session_id %>
    </pre>
    """
  end
end
