defmodule Jsonex do
  @moduledoc """
  Documentation for Jsonex.
  """

  def encode(nil), do: "null"

  def encode(term) when is_tuple(term) or is_pid(term) or is_float(term) do
    raise Jsonex.BadInputError, term
  end

  def encode(term) when is_boolean(term), do: to_string(term)

  def encode(term) when is_binary(term) or is_atom(term), do: escaped(term)

  def encode(term) when is_map(term) do
    "{#{Enum.map_join(term, ",", fn {k, v} -> encode(k, v) end)}}"
  end

  def encode(term) when is_list(term) do
    "[#{Enum.map_join(term, ",", &encode/1)}]"
  end

  def encode(term), do: to_string(term)

  def encode(term1, term2), do: "#{encode(term1)}:#{encode(term2)}"

  defp escaped(term), do: "\"#{to_string(term)}\""
end

defmodule Jsonex.BadInputError do
  defexception [:message]

  @impl true
  def exception(value) do
    msg = "did not get what was expected, got: #{inspect(value)}"
    %Jsonex.BadInputError{message: msg}
  end
end
