defmodule Day04 do
  import Enum

  def run do
    sets =
      Regex.scan(~r/\d+/, File.read!("data/day04.txt") |> String.trim())
      |> map(&hd/1)
      |> map(&String.to_integer/1)
      |> chunk_every(4)
      |> map(&to_sets/1)

    part1 = sets |> filter(&range_contain?/1) |> length
    part2 = sets |> filter(&overlap?/1) |> length

    {part1, part2}
  end

  def to_sets([a1, a2, b1, b2]), do: {MapSet.new(a1..a2), MapSet.new(b1..b2)}
  def range_contain?({a, b}), do: MapSet.subset?(a, b) || MapSet.subset?(b, a)
  def overlap?({a, b}), do: MapSet.intersection(a, b) |> empty? |> Kernel.not()
end
