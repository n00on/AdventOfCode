defmodule Day13 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    |> Enum.map(fn pattern -> String.split(pattern) |> Enum.map(&String.graphemes/1) end)
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    (input |> Stream.map(&col_mirror/1)
    |> Enum.sum) + 100 *
    (input |> Stream.map(&row_mirror/1)
    |> Enum.sum)
  end

  def row_mirror(pattern) do
    height = length(pattern)
    rows = (for y <- 1..(height - 1) do
      range = min(height - y, y) - 1
      #IO.inspect({0..range, (y-range-1)..(y+range)})
      Enum.all?(0..range, fn i -> Enum.at(pattern, y-i - 1) == Enum.at(pattern, y+i) end)
    end
    |> Enum.find_index(fn b -> b end))
    if rows, do: rows + 1, else: 0
  end

  def col_mirror(pattern) do
    pattern
    |> Stream.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> row_mirror()
  end

  def part_2(input) do
    :ok
  end

end

Day13.start()
