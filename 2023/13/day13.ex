defmodule Day13 do
  
  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    |> Enum.map(fn pattern -> String.split(pattern) |> Enum.map(&String.graphemes/1) end)
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    (input |> Stream.map(&row_mirror/1)
    #|> Enum.sum
    ) |> Enum.to_list
    #+ 100 *
  end

  def row_mirror(pattern) do
    height = length(pattern)
    rows = (for y <- 1..(height - 1) do
      range = min(height - y, y)
      IO.inspect((y-range)..(y - 1))
      Enum.all?((y-range)..(y - 1), fn i -> Enum.at(pattern, y-i - 1) == Enum.at(pattern, y+i) end)
    end
    |> Enum.find_index(fn b -> b end)) 
    if rows, do: rows, else: 0
  end

  def part_2(input) do
    :ok
  end

end

Day13.start()

