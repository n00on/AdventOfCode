defmodule Day12 do
  
  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n")
    parsed = for line <- input do
      [record, expected] = String.split(line)
      {String.graphemes(record), String.split(expected, ",") |> Enum.map(&String.to_integer/1)}
    end
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    parsed2 = for line <- input do
      [record, expected] = String.split(line)
      {String.graphemes(record |> List.duplicate(5) |> Enum.join("?")),
        String.split(expected, ",") |> Enum.map(&String.to_integer/1) |> List.duplicate(5) |> Enum.concat()}
    end
    IO.puts("Part 2: " <> inspect(part_2(parsed2)))
  end

  def part_1(parsed) do
    #IO.inspect(parsed)
    Stream.map(parsed, fn {line, expected} -> configurations(line, expected) end)
    |> Enum.sum()
  end

  def configurations(rest, []), do: if Enum.all?(rest, fn c -> c != "#" end), do: 1, else: 0
  def configurations([], _), do: 0
  def configurations(["." | rest], expected), do: configurations(rest, expected)
  def configurations(["?" | rest], [next | expected]) do
    configurations(rest, [next | expected]) + (if is_possible(rest, next - 1), do: configurations(Enum.drop(rest, next), expected), else: 0)
  end
  def configurations(["#" | rest], [next | expected]) do
    if is_possible(rest, next - 1), do: configurations(Enum.drop(rest, next), expected), else: 0
  end

  def is_possible([cell | _], 0), do: cell != "#"
  def is_possible([], len), do: len == 0
  def is_possible([cell | rest], len) do
    cell != "." and is_possible(rest, len-1)
  end

  def part_2(parsed) do
    me = self()
    Enum.each(parsed, fn {line, expected} -> spawn(fn -> worker(line, expected, me) end) end)
    loop(0, length(parsed))
  end

  def worker(line, expected, pid) do
    send(pid, configurations(line, expected))
  end

  def loop(sum, 0), do: sum
  def loop(sum, n) do
    IO.inspect(sum, label: "#{inspect n}")
    receive do
      x -> loop(sum+x, n-1)
    end
  end

end

Day12.start()

