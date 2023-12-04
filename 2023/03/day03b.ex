defmodule Day03 do

  def start() do
    parsed = File.read!("input.txt") |> String.split()
    |> Enum.map(fn s -> ["." | String.graphemes(s)] ++ ["."] end)
    schematic = [String.duplicate(".", 160) | parsed] ++ [String.duplicate(".", 160)]
    IO.puts("Part 1: " <> inspect(part_1(schematic)))
    IO.puts("Part 2: " <> inspect(part_2(schematic)))
  end

  def part_1(parsed) do
    scan_lines(parsed, 1)
  end

  def scan_lines(schematic, y) when length(schematic) == y + 1, do: 0
  def scan_lines(schematic, y)  do
    scan_line(schematic, y, 1) + scan_lines(schematic, y + 1)
  end

  def scan_line(schematic, y, x) do
    if String.length(Enum.at(schematic, y)) <= x + 1 do
      0
    else
      if Regex.match?(~r/\*/, at(schematic, y, x)) do
        scan_gear(schematic, y, x) + scan_line(schematic, y, x+1)
      else
        scan_line(schematic, y, x + 1)
      end
    end
  end

  def scan_gear(schematic, y, x) do
    numbers = (for y1 <- (y - 1)..(y + 1), x1 <- (x - 1)..(x + 1), y1 != y or x1 != x, do: find_number(schematic, y1, x1))
    |> Stream.filter(fn int -> int != nil end)
    |> Enum.uniq()

    if length(numbers) == 2 do
      Enum.at(numbers, 0) * Enum.at(numbers, 1)
    else
      0
    end
  end

  def find_number(schematic, y, x) do
    if Regex.match?(~r/\d/, at(schematic, y, x)) do
      if Regex.match?(~r/\d/, at(schematic, y, x-1)) do
        find_number(schematic, y, x-1)
      else
        scan_number(schematic, y, x)
      end
    else
      nil
    end
  end

  def scan_number(schematic, y, x, n \\ "") do
    field = at(schematic, y, x)
    #if y == 6, do: IO.inspect({n, b})
    if !Regex.match?(~r/\d/, field) do
      String.to_integer(n)
    else
      scan_number(schematic, y, x+1, n <> field)
    end
  end

  defp at(schematic, y, x) do
    String.at(Enum.at(schematic, y), x)
  end

  defp blank(schematic, y, x) do
    Regex.match?(~r/(\d|.)/, at(schematic, y, x))
  end

  defp part_2(parsed) do
    :ok
  end

end

Day03.start()
