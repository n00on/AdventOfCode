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
    if length(Enum.at(schematic, y)) <= x + 1 do
      0
    else
      if at(schematic, y, x) == nil, do: IO.inspect({y,x})
      if Regex.match?(~r/\d/, at(schematic, y, x)) do
        scan_number(schematic, y, x)
      else
        scan_line(schematic, y, x + 1)
      end
    end
  end

  def scan_number(schematic, y, x, n \\ "", b \\ false) do
    field = at(schematic, y, x)
    #if y == 6, do: IO.inspect({n, b})
    if !Regex.match?(~r/\d/, field) do
      (if b, do: String.to_integer(n), else: 0) + scan_line(schematic, y, x+1)
    else
      new_b = b or !(for y1 <- (y - 1)..(y + 1), x1 <- (x - 1)..(x + 1), y1 != y or x1 != x, reduce: true,do: acc -> acc and blank(schematic, y1, x1))
      scan_number(schematic, y, x+1, n <> field, new_b)
    end
  end

  def at(schematic, y, x) do
    Enum.at(Enum.at(schematic, y), x)
  end

  def blank(schematic, y, x) do
    at(schematic, y, x) == "." or Regex.match?(~r/\d/, at(schematic, y, x))
  end

  def part_2(parsed) do
    :ok
  end

end

Day03.start()
