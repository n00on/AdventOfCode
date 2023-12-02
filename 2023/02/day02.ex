defmodule Day02 do

  def start() do
    parsed = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n")
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(parsed) do
    parsed |> Stream.map(fn string -> game_value(string) end) |> Enum.sum()
  end

  def game_value(game) do
    ["Game " <> n, patterns | _] = game |> String.trim() |> String.split(": ")
    if game_possible?(patterns, 12, 13, 14), do: String.to_integer(n), else: 0
  end

  def game_possible?(cubes, r, g, b) do
    cubes |> String.trim() |> String.split(~r/(,\s)|(;\s)/)
    |> Enum.map(fn s -> String.split(s) end)
    |> Enum.map(fn s -> cube_possible?(s, r, g, b) end)
    |> Enum.reduce(true, fn b, acc -> acc and b end)
  end

  def cube_possible?([n | ["red"]], r, _, _), do: String.to_integer(n) <= r
  def cube_possible?([n | ["green"]], _, g, _), do: String.to_integer(n) <= g
  def cube_possible?([n | ["blue"]], _, _, b), do: String.to_integer(n) <= b

  def part_2(parsed) do
    parsed |> Stream.map(fn game -> power(game) end) |> Enum.sum()
  end

  def power(game) do
    [_, cubes | _] = String.split(game, ": ")
    map = cubes |> String.trim() |> String.split(~r/(,\s)|(;\s)/) |> min_cubes(%{r: 0, g: 0, b: 0})
    map.r * map.g * map.b
  end

  def min_cubes([], map), do: map
  def min_cubes([cube | rest], map) do
    {n, key} = case String.split(cube) do
      [n | ["red"]] -> {n, :r}
      [n | ["green"]] -> {n, :g}
      [n | ["blue"]] -> {n, :b}
    end
    if String.to_integer(n) > Map.get(map, key) do
      min_cubes(rest, Map.put(map, key, String.to_integer(n)))
    else
      min_cubes(rest, map)
    end
  end

end

Day02.start()
