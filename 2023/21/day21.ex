defmodule Day21 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split()
    map = for row <- input do
      for cell <- String.graphemes(row) do
        cell != "#"
      end
    end #|> Enum.concat()
    {x,y} = Enum.find_value(input |> Stream.with_index(), fn {row,y} -> Enum.find_value(row |> String.graphemes() |> Stream.with_index(), fn {cell, x} -> if cell == "S", do: {x, y} end) end)
    IO.inspect({x,y})
    IO.inspect(part_1([{x,y}], map, 64), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(pos, _  , 0), do: length(pos)
  def part_1(pos, map, n) do
    for {x,y} <- pos do
      for {nx,ny} <- [{x+1, y}, {x-1,y}, {x, y+1}, {x,y-1}], at(map, nx, ny) do
        {nx,ny}
      end
    end
    |> Enum.concat()
    |> Enum.uniq()
    |> part_1(map, n-1)
  end

  def part_2(input) do
    :ok
  end

  def at(map, x, y) do
    map |> Enum.at(y) |> Enum.at(x)
  end

end

Day21.start()
