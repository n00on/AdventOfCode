defmodule Day11 do
  
  def start() do
    parsed = File.read!("input.txt") |> String.replace("\r", "") |> String.split()
    |> Enum.map(&String.graphemes/1) 
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(image) do
    find_all_distances(image)
  end

  def part_2(image) do
    find_all_distances(image, 1_000_000)
  end

  def find_empty_columns(image) do
    for x <- 0..(length(Enum.at(image, 0))-1), reduce: [] do
      list -> if Enum.all?(image, fn row -> Enum.at(row, x) != "#" end), do: [x | list], else: list
    end
  end

  def find_empty_rows(image) do
    for {row, y} <- Stream.with_index(image), reduce: [] do
      list -> if Enum.all?(row, fn pixel -> pixel != "#" end), do: [y | list], else: list
    end
  end

  def find_galaxies(image) do
    for {row, y} <- Stream.with_index(image), reduce: [] do
      list -> 
        (for {pixel, x} <- Stream.with_index(row), reduce: [] do
          acc -> if pixel == "#", do: [{x, y} | acc], else: acc
        end) ++ list
    end
  end

  def find_all_distances(image, expansion \\ 2) do
    empty_rows = find_empty_rows(image)
    empty_cols = find_empty_columns(image)
    galaxies = find_galaxies(image)
    for {{x1, y1}, i} <- Stream.with_index(galaxies), 
        {{x2, y2}, j} <- Stream.with_index(galaxies), j > i, reduce: 0 do
      sum -> sum +
        abs(x2 - x1) + abs(y2 - y1) +
        (expansion-1) * (in_range(empty_rows, y1, y2) + in_range(empty_cols, x1, x2))
    end
  end

  # how many in list are between l and r
  def in_range(list, r, l) when r > l, do: in_range(list, l, r)
  def in_range(list, l, r) do
    list |> Enum.filter(fn val -> l < val and val < r end) |> length()
  end

end

Day11.start()

