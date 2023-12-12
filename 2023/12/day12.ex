defmodule Day12 do
  
  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n")
    IO.puts("Part 1: " <> inspect(part_1(input)))
    IO.puts("Part 2: " <> inspect(part_2(input)))
  end

  def part_1(input) do
    parsed = for line <- input do
      [record, groups] = String.split(line)
      {String.graphemes(record), String.split(groups, ",") |> Enum.map(&String.to_integer/1)}
    end
    config_sum(parsed)
  end

  def config_sum(parsed) do
    Stream.map(parsed, fn {line, groups} -> configurations(line, groups, %{}) |> elem(0) end)
    |> Enum.sum()
  end

  def configurations(springs , []    , lookup), do: {(if Enum.all?(springs, fn c -> c != "#" end), do: 1, else: 0), lookup}
  def configurations([]      , _     , lookup), do: {0, lookup}
  def configurations(["."|ss], groups, lookup), do: configurations(ss, groups, lookup)
  def configurations(springs , groups, lookup) do
    key = {springs, groups}
    case Map.get(lookup, key) do
      nil ->
        [spring | ss] = springs
        [group | gs] = groups
        {amt1, lookup1} = if spring == "?", # try ignore spring
            do: configurations(ss, groups, lookup),
            else: {0, lookup}
        {amt2, lookup2} = if possible?(ss, group - 1), #try taking group
            do: configurations(Enum.drop(ss, group), gs, lookup1),
            else: {0, lookup1}
        {amt1 + amt2, lookup2 |> Map.put(key, amt1+amt2)}
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
      record5 = String.graphemes(record |> List.duplicate(5) |> Enum.join("?"))
      groups5 = groups |> List.duplicate(5) |> Enum.join(",")
      |> String.split(",") |> Enum.map(&String.to_integer/1)
      {record5, groups5}
    end
    |> config_sum()
  end

end

Day12.start()

