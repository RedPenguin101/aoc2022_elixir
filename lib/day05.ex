defmodule Day05 do
  import Enum

  def run do
    input = File.read!("data/day05.txt") |> String.trim() |> String.split("\n")
    letters = fn str -> Regex.scan(~r/[A-Z]/, str) |> List.flatten() end

    start_state =
      input
      |> take(9)
      |> map(&to_charlist/1)
      |> pivot
      |> map(&to_string/1)
      |> map(letters)
      |> reject(&empty?/1)

    moves =
      input
      |> drop(10)
      |> map(&Utils.extract_ints/1)
      |> map(&List.to_tuple/1)

    part1_joiner = &list_into/2
    part2_joiner = &Kernel.++/2

    part1 =
      reduce(moves, start_state, &move(&1, &2, part1_joiner))
      |> map(&List.first/1)
      |> join

    part2 =
      reduce(moves, start_state, &move(&1, &2, part2_joiner))
      |> map(&List.first/1)
      |> join

    {part1, part2}
  end

  def list_into([], l2), do: l2
  def list_into([h | t], l2), do: list_into(t, [h] ++ l2)

  def move({x, from, to}, state, joiner) do
    f = at(state, from - 1)
    {mv, stay} = split(f, x)
    t = at(state, to - 1)
    new_to = joiner.(mv, t)

    state
    |> List.replace_at(from - 1, stay)
    |> List.replace_at(to - 1, new_to)
  end

  def pivot(lists) do
    max_length = map(lists, &length/1) |> max
    for idx <- 0..(max_length - 1), do: map(lists, &at(&1, idx))
  end
end
