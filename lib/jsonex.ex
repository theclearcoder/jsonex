defmodule Jsonex do
  @moduledoc """
  Documentation for Jsonex.
  """

  def encode(str) do
    # Your code goes here
    :TODO_IMPLEMENT_ME
  end
end

defmodule Jsonex.BadInputError do
  defexception [:message]

  @impl true
  def exception(value) do
    msg = "did not get what was expected, got: #{inspect(value)}"
    %Jsonex.BadInputError{message: msg}
  end
end
