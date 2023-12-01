defmodule Day01 do

  def start() do
    parsed = File.read!("input.txt") |> String.split()
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(parsed) do
    parsed |> Enum.reduce(0, fn string, sum -> sum + get_value(string) end)
  end

  def get_value(string) do
    matches = Regex.scan(~r/\d/, string, capture: :first)

    hd(hd(matches) <> hd(List.last(matches)))
    |> String.to_integer()
  end

  def part_2(parsed) do
    for(string <- parsed, do: insert(string)) |> part_1()
  end

  def insert(""), do: ""
  def insert(string) do
    map = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    # Inserts the number spelled out before the textual occurence.
    case Enum.find_index(map, fn word -> String.starts_with?(string, word) end) do
      nil -> ""
      n -> Integer.to_string(n + 1)
    end <>
      String.at(string, 0) <> insert(String.slice(string, 1..-1//1))
  end
end

Day01.start()
