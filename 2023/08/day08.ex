defmodule Day08 do

  def start() do
    [instruct, maps]= File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    parsed_instruct = for dir <- String.graphemes(instruct) do
      if dir == "L", do: 0, else: 1
    end |> List.to_tuple()
    parsed_maps = parse_maps(String.split(maps, "\n"), %{})
    IO.puts("Part 1: " <> inspect(part_1(parsed_maps, parsed_instruct)))
  end

  def part_1(map, instruct) do
    start = "AAA"
    find_goal(map, start, instruct, 0)
  end

  def find_goal(map, pos, instruct, step) do
    dir = elem(instruct, Integer.mod(step, tuple_size(instruct)))
    new_pos = elem(Map.get(map, pos), dir)
    if new_pos == "ZZZ" do
      step + 1
    else
      find_goal(map, new_pos, instruct, step + 1)
    end
  end

  def parse_maps([], map), do: map
  def parse_maps([map_str | rest], map) do
    [start, l, r] = map_str |> String.replace(~r/=|\(|,|\)/, "") |> String.split()
    parse_maps(rest, Map.put(map, start, {l, r}))
  end

end

Day08.start()
