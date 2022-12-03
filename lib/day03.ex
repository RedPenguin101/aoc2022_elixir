defmodule Day03 do
  import Enum

  def run do
    part1 = File.read!("data/day03.txt")
    |> String.split()
    |> map(&common_char/1)
    |> map(&prioritize/1)
    |> sum

    part2 = File.read!("data/day03.txt")
    |> String.split()
    |> chunk_every(3)
    |> map(&badge/1)
    |> map(&prioritize/1)
    |> sum

    {part1, part2}
  end

  def common_char(str) do
    {l, r} = str |> to_charlist |> split(div(String.length(str), 2))
    MapSet.intersection(MapSet.new(l), MapSet.new(r)) |> take(1) |> hd
  end

  def badge(trio) do
    trio
    |> map(&to_charlist/1)
    |> map(&MapSet.new/1)
    |> reduce(&MapSet.intersection/2)
    |> take(1)
    |> hd
  end

  def prioritize(x), do: if x >= 96, do: x - 96, else: x - 38
end
