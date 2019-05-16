defmodule Jsonex do
  @moduledoc """
  Documentation for Jsonex.
  """

  def encode(nil), do: "null"

  def encode(str) when is_tuple(str) or is_pid(str) or is_float(str) do
    raise Jsonex.BadInputError, str
  end

  def encode(str) when is_boolean(str), do: to_string(str)

  def encode(str) when is_binary(str) or is_atom(str), do: escaped(str)

  def encode(str) when is_map(str) do
    "{#{Enum.map_join(str, ",", fn {k, v} -> encode(k, v) end)}}"
  end

  def encode(str) when is_list(str) do
    "[#{Enum.map_join(str, ",", &encode/1)}]"
  end

  def encode(str), do: to_string(str)

  def encode(str1, str2), do: "#{encode(str1)}:#{encode(str2)}"

  defp escaped(str), do: "\"#{to_string(str)}\""
end

defmodule Jsonex.BadInputError do
  defexception [:message]

  @impl true
  def exception(value) do
    msg = "did not get what was expected, got: #{inspect(value)}"
    %Jsonex.BadInputError{message: msg}
  end
end
