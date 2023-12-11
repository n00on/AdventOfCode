defmodule Day11 do
  
  def start() do
    parsed = File.read!("input.txt") |> String.replace("\r", "") |> String.split() |> Enum.map(&String.graphemes/1)
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(map) do
    find_all_distances(map)
  end

  def find_empty_columns(map) do
    for x <- 0..(length(Enum.at(map, 0))-1), reduce: [] do
      acc -> 
        if (for y <- 0..(length(map)-1), reduce: true do
          acc -> acc and at(map, x, y) != "#"
        end), do: [x | acc], else: acc
    end
  end

  def find_empty_rows(map) do
    for y <- 0..(length(map)-1), reduce: [] do
      acc -> 
        if (for x <- 0..(length(Enum.at(map, y))-1), reduce: true do
          acc -> acc and at(map, x, y) != "#"
        end), do: [y | acc], else: acc
    end
  end

  def find_galaxies(map) do
    for y <- 0..(length(map)-1), reduce: [] do
      acc -> 
        (for x <- 0..(length(Enum.at(map, y))-1), reduce: [] do
          acc -> if at(map, x, y) == "#", do: [{x, y} | acc], else: acc
        end) ++ acc
    end
  end

  def find_all_distances(map, expansion \\ 1) do
    emptyr = find_empty_rows(map)
    emptyc = find_empty_columns(map)
    galaxies = find_galaxies(map)
    for {{x1, y1}, i} <- Enum.with_index(galaxies), reduce: 0 do
      acc -> acc + 
        for {x2, y2} <- Enum.slice(galaxies, (i+1)..-1//1), reduce: 0 do
          acc -> acc +
            abs(x2 - x1) + abs(y2 - y1) +
            expansion * (
              length(Enum.filter(emptyc, fn x -> x > x2 and x < x1 or x > x1 and x < x2 end)) + 
              length(Enum.filter(emptyr, fn y -> y > y2 and y < y1 or y > y1 and y < y2 end)))
        end
      end
  end

  def part_2(map) do
    find_all_distances(map, 999999)
  end

  def at(map, x, y) do
    map |> Enum.at(y) |> Enum.at(x)
  end

end

Day11.start()

