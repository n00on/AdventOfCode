defmodule Day12 do
  
  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n")
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    for line <- input do
      [record, groups] = String.split(line)
      {String.graphemes(record), String.split(groups, ",") |> Enum.map(&String.to_integer/1)}
    end
    |> config_sum()
  end

  def config_sum(parsed) do
    Stream.map(parsed, fn {line, groups} -> arrangements(line, groups, %{}) |> elem(0) end)
    |> Enum.sum()
  end

  def arrangements(springs , []    , lookup), do: {(if Enum.all?(springs, fn c -> c != "#" end), do: 1, else: 0), lookup}
  def arrangements([]      , _     , lookup), do: {0, lookup}
  def arrangements(["."|ss], groups, lookup), do: arrangements(ss, groups, lookup)
  def arrangements(springs , groups, lookup) do
    key = {springs, groups}
    case Map.get(lookup, key) do
      nil ->
        [spring | ss] = springs
        [group | gs] = groups
        {amt1, lookup} = if spring == "?", # try ignore spring
            do: arrangements(ss, groups, lookup),
            else: {0, lookup}
        {amt2, lookup} = if possible?(ss, group - 1), #try taking group
            do: arrangements(Enum.drop(ss, group), gs, lookup),
            else: {0, lookup}
        {amt1 + amt2, lookup |> Map.put(key, amt1+amt2)}
      amt ->
        {amt, lookup}
    end
  end

  def possible?([spring | _] ,   0), do: spring != "#"
  def possible?([]           , len), do: len == 0
  def possible?([spring | ss], len), do: spring != "." and possible?(ss, len-1)

  def part_2(input) do
    for line <- input do
      [record, groups] = String.split(line)
      record = String.graphemes(record |> List.duplicate(5) |> Enum.join("?"))
      groups = groups |> List.duplicate(5) |> Enum.join(",")
      |> String.split(",") |> Enum.map(&String.to_integer/1)
      {record, groups}
    end
    |> config_sum()
  end

end

Day12.start()

