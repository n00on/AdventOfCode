defmodule Day10 do

  def start() do
    parsed = File.read!("input.txt") |> String.replace("\r", "") |> String.split() |> Enum.map(fn s -> ["." | String.graphemes(s)] ++ ["."] end)
    padded = [List.duplicate(".", 160) | parsed] ++ [List.duplicate(".", 160)]
    map = (padded |> Enum.map(&List.to_tuple/1)) |> List.to_tuple()
    {sx, sy} = find_start(padded)
    {s, {xdir, ydir}} = get_start(map, sx, sy)
    full_map = replace(map, sx, sy, s)
    path = find_path(map, sx+xdir, sy+ydir, sx, sy, 1)

    IO.puts("Part 1: " <> inspect(part_1(path)))
    IO.puts("Part 2: " <> inspect(part_2(full_map, path)))
  end

  def part_1(path) do
    div(length(path), 2)
  end

  def find_start(padded) do
    for {line, y} <- Enum.with_index(padded), reduce: nil do
      acc ->
        case Enum.find_index(line, fn c -> c == "S" end) do
          nil -> acc
          x -> {x, y}
        end
    end
  end

  def get_start(map, x, y) do
    left = at(map, x - 1, y) in ["-", "F", "L"]
    right = at(map, x + 1, y) in ["-", "J", "7"]
    up = at(map, x, y - 1) in ["|", "F", "7"]
    down = at(map, x, y + 1) in ["|", "J", "L"]
    case {left, right, up, down} do
      {true, true, false, false} -> {"-", {1, 0}}
      {false, false, true, true} -> {"|", {0, 1}}
      {false, true, true, false} -> {"L", {1, 0}}
      {true, false, true, false} -> {"J", {-1, 0}}
      {true, false, false, true} -> {"7", {-1, 0}}
      {false, true, false, true} -> {"F", {1, 0}}
    end
  end

  def find_path(map, x, y, xf, yf, dist) do
    xdif = x-xf
    ydif = y-yf
    [{x, y} | case at(map, x, y) do
      "S" -> []
      "|" -> find_path(map, x, y + ydif, x, y, dist + 1)
      "-" -> find_path(map, x + xdif, y, x, y, dist + 1)
      "L" -> find_path(map, x + ydif, y + xdif, x, y, dist + 1)
      "J" -> find_path(map, x - ydif, y - xdif, x, y, dist + 1)
      "7" -> find_path(map, x + ydif, y + xdif, x, y, dist + 1)
      "F" -> find_path(map, x - ydif, y - xdif, x, y, dist + 1)
    end]
  end

  def part_2(map, path) do
    for y <- 0..(tuple_size(map) - 1), reduce: 0 do
      acc -> acc + scan_row(map, path, 0, y, 0, false) # ignore padded lines
    end
  end

  def scan_row(map, _path, x, y, count, _inside) when x == tuple_size(elem(map, y)) - 1, do: count
  def scan_row(map, path, x, y, count, inside) do
    if {x, y} in path do
      case at(map, x, y) do
        "|" -> scan_row(map, path, x+1, y, count, !inside)
        "L" -> go_to_edge_end(map, path, x+1, y, count, inside, "7")
        "F" -> go_to_edge_end(map, path, x+1, y, count, inside, "J")
      end
    else
      new_count = if inside, do: count + 1, else: count
      scan_row(map, path, x+1, y, new_count, inside)
    end
  end

  def go_to_edge_end(map, _path, x, y, count, _inside, _c) when x == tuple_size(elem(map, y)) - 1, do: count
  def go_to_edge_end(map, path, x, y, count, inside, expected) do
    case at(map, x, y) do
      "-" -> go_to_edge_end(map, path, x+1, y, count, inside, expected)
      pipe ->
        new_inside = if pipe == expected, do: !inside, else: inside
        scan_row(map, path, x+1, y, count, new_inside)
    end
  end

  def at(map, x, y) do
    map |> elem(y) |> elem(x)
  end

  def replace(map, x, y, c) do
    map |> Tuple.delete_at(y) |> Tuple.insert_at(y, (map |> elem(y) |> Tuple.delete_at(x) |> Tuple.insert_at(x, c)))
  end

end

Day10.start()
