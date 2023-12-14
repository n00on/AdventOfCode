defmodule Day13 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    |> Enum.map(fn pattern -> String.split(pattern) |> Enum.map(&String.graphemes/1) end)
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    get_result(input)
  end

  def get_result(input, smudge \\ 0) do
    (input |> Stream.map(fn p -> col_mirror(p, smudge) end)
    |> Enum.sum) + 100 *
    (input |> Stream.map(fn p -> row_mirror(p, smudge) end)
    |> Enum.sum)
  end

  def row_mirror(pattern, smudge \\ 0) do
    height = length(pattern)
    rows = (for y <- 1..(height - 1) do
      range = min(height - y, y) - 1
      Enum.map(0..range, fn i ->
        Enum.zip(Enum.at(pattern, y-i - 1), Enum.at(pattern, y+i))
        |> Enum.count(fn {a, b} -> a != b end)
      end)
      |> Enum.sum()
    end
    |> Enum.find_index(fn c -> smudge == c end))
    if rows, do: rows + 1, else: 0
  end

  def col_mirror(pattern, smudge \\ 0) do
    pattern
    |> Stream.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> row_mirror(smudge)
  end

  def part_2(input) do
    get_result(input, 1)
  end

end

Day13.start()
