defmodule Utils do
  import Enum

  def map_invert(m), do: Map.new(m, fn {key, val} -> {val, key} end)

  def extract_ints(str) do
    Regex.scan(~r/\d+/, str)
    |> map(&hd/1)
    |> map(&String.to_integer/1)
  end
end
