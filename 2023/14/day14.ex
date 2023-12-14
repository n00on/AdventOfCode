defmodule Day14 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split()
    |> Enum.map(&String.graphemes/1) |> Enum.map(&List.to_tuple/1) |> List.to_tuple()
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    map = for _ <- 0..4000 do
      roll_north(input, 1)
    end
    map = roll_north(input, 1)
    for y <- 0..(tuple_size(map) - 1), reduce: 0 do
      sum ->
        sum + (tuple_size(map) - y) * Enum.count(elem(map, y) |> Tuple.to_list, fn cell -> cell == "O" end)
    end
  end

  def roll_north(map, y) when tuple_size(map) == y, do: map
  def roll_north(map, y) do
    #IO.inspect(map)
    row = elem(map, y)
    for x <- 0..(tuple_size(row)-1), reduce: map do
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
    map |> elem(y) |> elem(x)
  end

  def update(map, x, y, xn, yn) do
    #IO.inspect({map, x, y, xn, yn})
    map |> put_elem(y, put_elem(elem(map, y), x, "."))
    |> put_elem(yn, put_elem(elem(map, yn), xn, "O"))
  end

end

Day14.start()
