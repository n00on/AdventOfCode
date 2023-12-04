defmodule Day04 do

  def start() do
    parsed = File.read!("input.txt") |> String.split("\n")
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(cards) do
    for card <- cards, reduce: 0 do
      acc ->
        wins = get_wins(card)
        acc + if wins > 0, do: Integer.pow(2, wins - 1), else: 0
    end
  end

  def get_wins(card) do
    ["Card " <> _n, numbers] = (card |> String.trim() |> String.split(": "))
    [have, winning] = numbers |> String.split(" | ")
    for h <- String.split(have), w <- String.split(winning), reduce: 0 do
      acc -> if h == w, do: acc + 1, else: acc
    end
  end

  def part_2(cards) do
    number_of_cards = for _card <- cards, do: 1
    Enum.sum(play(cards, number_of_cards, 0))
  end

  def play(cards, number_of_cards, i) when length(cards) - 1 == i, do: number_of_cards
  def play(cards, number_of_cards, i) do
    wins = get_wins(Enum.at(cards, i))
    number_of_cards = for {n, j} <- Enum.with_index(number_of_cards) do
      if j > i and j <= i + wins, do: n + Enum.at(number_of_cards, i), else: n
    end
    play(cards, number_of_cards, i + 1)
  end

end

Day04.start()
