defmodule Day01 do

  def read() do
    case File.read("input.txt") do
      {:ok, binary} ->
        parsed = String.split(binary)
        IO.puts("Part 1: " <> inspect(part_1(parsed)))
        IO.puts("Part 2: " <> inspect(part_2(parsed)))

      {:error, reason} ->
        IO.puts(reason)
    end
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
    for(string <- parsed, do: insert(string))
    |> part_1()
  end

  @doc """
  Inserts the number spelled out before their texutal occurence.
  """
  def insert(""), do: ""
  def insert(string) do
    case string do
      "one" <> _rest -> "1"
      "two" <> _rest -> "2"
      "three" <> _rest -> "3"
      "four" <> _rest -> "4"
      "five" <> _rest -> "5"
      "six" <> _rest -> "6"
      "seven" <> _rest -> "7"
      "eight" <> _rest -> "8"
      "nine" <> _rest -> "9"
      _ -> ""
    end <>
      String.at(string, 0) <> insert(String.slice(string, 1..-1//1))
  end
end

Day01.read()
