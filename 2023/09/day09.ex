defmodule Day09 do

  def start() do
    parsed = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n")
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(parsed) do
    for series <- parsed, reduce: 0 do
      acc -> acc + find_next(series |> String.split() |> Enum.map(&String.to_integer/1))
    end
  end

  def find_next(values) do
    diffs = for [v1, v2] <- Stream.chunk_every(values, 2, 1) do
      v2 - v1
    end
    if Enum.all?(diffs, fn v -> v == 0 end) do
      List.last(values)
    else
      find_next(diffs) + List.last(values)
    end
  end

  def part_2(parsed) do
    for series <- parsed, reduce: 0 do
      acc -> acc + find_next(series |> String.split() |> Enum.map(&String.to_integer/1) |> Enum.reverse())
    end
  end

end

Day09.start()
