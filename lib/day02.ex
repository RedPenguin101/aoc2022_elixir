defmodule Day02 do
  import Enum
  # A/X rock
  # B/Y paper
  # C/Z scissors
  # A < B < C < A

  @trans %{"A" => :rock, "B" => :paper, "C" => :scissors,
           "X" => :rock, "Y" => :paper, "Z" => :scissors}
  @beats %{rock: :scissors, scissors: :paper, paper: :rock}
  @pick_score %{rock: 1, paper: 2, scissors: 3}

  def run do
    input = File.read!("data/day02.txt")
    |> String.split()
    |> chunk_every(2)
    |> map(&List.to_tuple/1)

    part1 = input |> map(&decrypt/1)  |> map(&score/1) |> sum
    part2 = input |> map(&decrypt2/1) |> map(&score/1) |> sum
    {part1, part2}
  end

  def decrypt({a,b}), do: {Map.get(@trans, a), Map.get(@trans, b)}

  def decrypt2{a,b} do
    a = Map.get(@trans, a)
    b = case b do
      "X" -> Map.get(@beats, a)
      "Y" -> a
      "Z" -> Map.get(Utils.map_invert(@beats), a)
    end
    {a, b}
  end

  def score{a, b} do
    b_beats = Map.get(@beats, b)

    result_score = cond do
      b == a       -> 3
      b_beats == a -> 6
      :else        -> 0
    end

    Map.get(@pick_score, b) + result_score
  end
end
