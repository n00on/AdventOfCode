defmodule Day14 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split()
    |> Enum.map(&String.graphemes/1) |> Enum.map(&List.to_tuple/1) |> List.to_tuple()
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    roll_north(input, 1)
    |> get_north_beam()
  end

  def roll_north(map, y) when tuple_size(map) == y, do: map
  def roll_north(map, y) do
    for x <- 0..(length(at(map, y))-1), reduce: map do
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

  def get_north_beam(map) do
    for {row, y} <- Stream.with_index(map), reduce: 0 do
      sum -> sum + (length(map) - y) * Enum.count(row, fn cell -> cell == "O" end)
    end
  end

  def part_2(input) do
    {map, hist} = Enum.reduce_while(1..1000000000, {input, []}, fn _, {map, hist} ->
      new_map = roll_cycle(map)
      if new_map in hist do
        {:halt, {new_map, hist}} # found cycle
      else
        {:cont, {new_map, [new_map | hist]}}
      end
    end)
    cycle_length = Enum.find_index(hist, fn m -> m == map end) + 1
    cycle_rem = rem(1000000000 - length(hist), cycle_length)
    get_north_beam(Enum.at(hist, cycle_length - cycle_rem))
  end

  def roll_cycle(map) do
    map
    |> roll_north(1) |> transpose()
    |> roll_north(1) |> transpose()
    |> roll_north(1) |> transpose()
    |> roll_north(1) |> transpose()
  end

  def at(map, x, y) do
    map |> elem(y) |> elem(x)
  end

  def update(map, x, y, xn, yn) do
    map
    |> List.replace_at(y, List.replace_at(Enum.at(map, y), x, "."))
    |> List.replace_at(yn, List.replace_at(Enum.at(map, yn), xn, "O"))
  end

  def transpose(rows) do
    rows
    |> List.zip
    |> Stream.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.reverse/1)
  end

end

Day14.start()
