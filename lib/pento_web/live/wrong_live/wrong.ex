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
    DateTime.utc_now() |> to_string()
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(data)

    number_to_guess = socket.assigns.number_to_guess

    if String.to_integer(guess) == number_to_guess do
      message = "Congrats! Your guess #{guess} is correct"
      score = socket.assigns.score + 5

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
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>

    <h2>
      <%= @message %> <span class="block">It's: <%= @current_time %></span>
    </h2>
    <br />
    <h2>
      <%= for n <- 1..10 do %>
        <.link
          class="bg-blue-500 hover:bg-blue-700
          text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
          phx-click="guess"
          phx-value-number={n}
        >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end
end
