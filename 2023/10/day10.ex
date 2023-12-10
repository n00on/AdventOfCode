defmodule Day10 do

  def start() do
    parsed = File.read!("input.txt") |> String.replace("\r", "") |> String.split() |> Enum.map(fn s -> ["." | String.graphemes(s)] ++ ["."] end)
    padded = [List.duplicate(".", 160) | parsed] ++ [List.duplicate(".", 160)]
    {x, y} = for {line, y} <- Enum.with_index(padded), reduce: nil do
      acc ->
        case Enum.find_index(line, fn c -> c == "S" end) do
          nil -> acc
          x -> {x, y}
        end
    end
    IO.inspect({x-1, y-1})
    map = (padded |> Enum.map(&List.to_tuple/1)) |> List.to_tuple()
    IO.puts("Part 1: " <> inspect(part_1(map, x , y)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(map, x, y) do
    for y1 <- (y - 1)..(y + 1), x1 <- (x - 1)..(x + 1), (y1 != y or x1 != x) and (y1 == y or x1 == x) do
      if at(map, x1, y1) != "." do
        IO.inspect(div(find_next(map, x, y, x1, y1, 1), 2))
      end
    end
  end

  def find_next(map, xf, yf, x, y, dist) do
    xdif = x-xf
    ydif = y-yf
    case at(map, x, y) do
      "S" -> dist
      "|" -> find_next(map, x, y, x, y + ydif, dist + 1)
      "-" -> find_next(map, x, y, x + xdif, y, dist + 1)
      "L" -> find_next(map, x, y, x + ydif, y + xdif, dist + 1)
      "J" -> find_next(map, x, y, x - ydif, y - xdif, dist + 1)
      "7" -> find_next(map, x, y, x + ydif, y + xdif, dist + 1)
      "F" -> find_next(map, x, y, x - ydif, y - xdif, dist + 1)
    end
  end

  def part_2(parsed) do
    :ok
  end

  def at(map, x, y) do
    elem(elem(map, y), x)
  end

end

Day10.start()
