defmodule Day14 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split()
    |> Enum.map(&String.graphemes/1)
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    map = roll_north(input, 1)
    for {row, y} <- Stream.with_index(map), reduce: 0 do
      sum -> sum + (length(map) - y) * Enum.count(row, fn cell -> cell == "O" end)
    end
  end

  def roll_north(map, y) when length(map) == y, do: map
  def roll_north(map, y) do
    #IO.inspect(map)
    row = Enum.at(map, y)
    for x <- 0..(length(row)-1), reduce: map do
      acc ->
        if at(acc, x, y) == "O" do
          yn = roll_cell(acc, y, x)
          update(acc, x, y, x, yn)
        else
          acc
        end
    end
    |> roll_north(y + 1)
  end

  def roll_cell(_  , 0, _), do: 0
  def roll_cell(map, y, x) do
    if at(map, x, y-1) == "." do
      roll_cell(map, y-1, x)
    else
      y
    end
  end

  def part_2(input) do
    :ok
  end

  def at(map, x, y) do
    map |> Enum.at(y) |> Enum.at(x)
  end

  def update(map, x, y, xn, yn) do
    #IO.inspect({map, x, y, xn, yn})
    map |> List.replace_at(y, List.replace_at(Enum.at(map, y), x, "."))
    |> List.replace_at(yn,
    List.replace_at(Enum.at(map, yn), xn, "O"))
  end

end

Day14.start()
