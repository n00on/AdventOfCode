defmodule Day01 do

  def read() do
    parsed = File.read!("input.txt") |> String.split()
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(parsed) do
    parsed |> Enum.reduce(0, fn string, sum -> sum + first(string) * 10 + last(string) end)
  end

  def first(string) do
    string
    |> to_charlist() # assume only ASCII
    |> Enum.map(fn v -> v - 48 end) # subtract ASCII of '0'
    |> Enum.find(fn x -> x >= 0 and x <= 9 end)# find number
  end

  def last(string) do
    string |> String.reverse() |> first()
  end

  def part_2(parsed) do
    for(string <- parsed, do: insert(string)) |> part_1()
  end

  def insert(""), do: ""
  def insert(string) do
    map = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    case Enum.find_index(map, fn word -> String.starts_with?(string, word) end) do
      nil -> ""
      n -> Integer.to_string(n + 1)
    end <> # Inserts the number spelled out before the textual occurence.
      String.at(string, 0) <> insert(String.slice(string, 1..-1//1))
  end
end

Day01.read()
