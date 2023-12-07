defmodule Day07 do

  def start() do
    parsed = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n") |> Stream.map(&String.split/1)
    input = for [card, bid] <- parsed, do: {String.graphemes(card), String.to_integer(bid)}
    IO.puts("Part 1: " <> inspect(part_1(input)))
    IO.puts("Part 2: " <> inspect(part_2(input)))
  end

  def part_1(parsed) do
    play(parsed)
  end

  def part_2(parsed) do
    play(parsed, true)
  end

  def play(parsed, joker \\ false) do
    sorted = parsed |> Enum.sort(fn {card1, _}, {card2, _} -> compare(card2, card1, joker) end)
    for {{_card, bid}, i} <- Stream.with_index(sorted), reduce: 0 do
      acc -> acc + bid*(i+1)
    end
  end

  def compare(a, b, joker) do
    a_type = get_type(a, joker)
    b_type = get_type(b, joker)
    cond do
      a_type < b_type -> false
      a_type > b_type -> true
      true -> compare_digits(a,b, joker)
    end
  end

  def compare_digits([],[], _), do: true
  def compare_digits([a | as], [b | bs], joker) do
    order = String.graphemes(if joker, do: "J23456789TQKA", else: "23456789TJQKA")
    a_val = Enum.find_index(order, fn c -> c == a end)
    b_val = Enum.find_index(order, fn c -> c == b end)
    cond do
      a_val < b_val -> false
      a_val > b_val -> true
      true -> compare_digits(as, bs, joker)
    end
  end

  def get_type(a, joker) do
    amt_map = a |> Enum.reduce(%{}, fn char, acc ->
      case acc do
        %{^char => count} -> %{acc | char => count + 1}
        _ -> Map.put(acc, char, 1)
      end
    end)

    jokers = if joker, do: Map.get(amt_map, "J", 0), else: 0
    case Enum.sort(Map.values(amt_map)) do
      [5] -> 7
      [1, 4] ->
        if jokers >= 1, do: 7, else: 6
      [2, 3] ->
        if jokers >= 2, do: 7, else: 5
      [1, 1, 3] ->
        if jokers >= 1, do: 6, else: 4
      [1, 2, 2] ->
        cond do
          jokers == 2 -> 6
          jokers == 1 -> 5
          true -> 3
        end
      [1, 1, 1, 2] ->
        if jokers >= 1, do: 4, else: 2
      [1, 1, 1, 1, 1] ->
        if jokers >= 1, do: 2, else: 1
    end
  end

end

Day07.start()
