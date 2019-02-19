defmodule JsonexTest do
  use ExUnit.Case

  describe "encode/1 with primitive types" do
    test "encodes strings" do
      assert Jsonex.encode("hello") == "\"hello\""
    end

    test "encodes atoms" do
      assert Jsonex.encode(:ok) == "\"ok\""
    end

    test "encodes numbers" do
      assert Jsonex.encode(1234) == "1234"
    end

    test "encodes booleans" do
      assert Jsonex.encode(true) == "true"
      assert Jsonex.encode(false) == "false"
    end

    test "encodes nil" do
      assert Jsonex.encode(nil) == "null"
    end
  end

  describe "encode/1 with lists" do
    test "encodes empty" do
      assert Jsonex.encode([]) == "[]"
    end

    test "encodes with values" do
      original = [1234, false, "hello"]
      encoded = "[1234,false,\"hello\"]"
      assert Jsonex.encode(original) == encoded
    end

    test "encodes list of lists" do
      original = [[1234, false], [nil, "hello"]]
      encoded = "[[1234,false],[null,\"hello\"]]"
      assert Jsonex.encode(original) == encoded
    end
  end

  describe "encode/1 with maps" do
    test "encodes empty" do
      assert Jsonex.encode(%{}) == "{}"
    end

    test "encodes with values" do
      original = %{status: :active, success: false}
      encoded = "{\"status\":\"active\",\"success\":false}"
      assert Jsonex.encode(original) == encoded
    end

    test "encodes map of maps" do
      original = %{
        one: %{
          two: %{
            three: :four
          }
        }
      }

      encoded = "{\"one\":{\"two\":{\"three\":\"four\"}}}"
      assert Jsonex.encode(original) == encoded
    end

    test "encodes map of list of maps" do
      original = %{
        one: [
          %{two: true},
          %{three: nil}
        ]
      }

      encoded = "{\"one\":[{\"two\":true},{\"three\":null}]}"
      assert Jsonex.encode(original) == encoded
    end
  end

  describe "encode/1 with invalid types" do
    test "raises on tuples" do
      assert_raise Jsonex.BadInputError, fn -> Jsonex.encode({:ok, true}) end
    end

    test "raises on pids" do
      pid = self()
      assert_raise Jsonex.BadInputError, fn -> Jsonex.encode(pid) end
    end

    test "raises on floats" do
      assert_raise Jsonex.BadInputError, fn -> Jsonex.encode(2.5) end
    end
  end
end
