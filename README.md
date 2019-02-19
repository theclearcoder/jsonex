# Jsonex

> Coding challenge for 2019.02.19 DFW Elixir Hack Night

## The Challenege

Write a JSON serializer in Elixir. To make unit tests pass, you will need to
implement the `Jsonex.encode/1` function defined in `lib/jsonex.ex`.

Example:

```elixir
iex> Jsonex.encode(%{success: true, foo: [1, 2, 3, 4]})
"{\"foo\":[1,2,3,4],\"success\":true}"
```

Not all data types can be converted to JSON. You must implement valid
conversions for the following types:

- Number
- String
- Booleans
- Nil
- List
- Map

Do not convert invalid types (pids, tuples, etc). Instead, you should raise a
`Jsonex.BadInputError`:

```elixir
iex> raise Jsonex.BadInputError, {:ok, 1234}
** (Jsonex.BadInputError) did not get what was expected, got: {:ok, 1234}
```

**Other things to note:**

- Strip all whitespace from your outputted JSON string
- Atoms should be converted to JSON strings
- Properly escape string quotes in the output
- Floats are not supported in the official JSON specification, raise a
  `BadInputError` instead
- Ignore implementing support for keyword lists

## Getting Started

Fetch dependencies and run the tests.

```
$ mix deps.get
$ mix test
```

All tests should be failing. Make them pass to complete the challenge!
