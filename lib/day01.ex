defmodule Day01 do
  import Enum
  import Utils

  def scratch do
    sums =
      File.read!("data/day01.txt")
      |> String.trim()
      |> String.split("\n\n")
      |> map(&extract_ints/1)
      |> map(&sum/1)

    part2 =
      sums
      |> sort(:desc)
      |> take(3)
      |> sum

    %{part1: max(sums), part2: part2}
  end
end
