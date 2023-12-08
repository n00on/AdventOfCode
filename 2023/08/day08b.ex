defmodule Day08 do
  
  def start() do
    [instruct, maps]= File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    #IO.inspect([instruct, maps])
    parsed_instruct = for dir <- String.graphemes(instruct) do
      if dir == "L", do: 0, else: 1
    end |> List.to_tuple()
    parsed_maps = parse_maps(String.split(maps, "\n"), %{})
    IO.puts("Part 1: " <> inspect(part_1(parsed_maps, parsed_instruct)))
    #IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(map, instruct) do
    start = Map.keys(map) |> Enum.filter(fn key -> String.ends_with?(key, "A") end) |> Enum.zip(Tuple.duplicate(0, 100))
    go_goal(map, start, instruct, %{})
  end

  def find_goal(map, pos, instruct, step) do
    dir = elem(instruct, Integer.mod(step, tuple_size(instruct)))
    new_pos = elem(Map.get(map, pos), dir)
    if new_pos == "ZZZ" do
      {new_pos, step}
    else
      find_goal(map, new_pos, instruct, step + 1)
    end
  end

  def go_goal(map, pos, instruct, to_map) do
    {min_pos, min_step} = Enum.min(pos)
    case to_map do
      %{{^min_pos, ^min_step} => {new_pos, new_step}} ->
      _ -> 
        {new_pos, new_step} = find_goal(map, min_pos, instruct, min_step)
        Map.put(to_map, {min_pos, min_step} )
    end
  end

  def part_2(parsed) do
    :ok
  end

  def parse_maps([], map), do: map
  def parse_maps([map_str | rest], map) do
    [start, l, r] = map_str |> String.replace(~r/=|\(|,|\)/, "") |> String.split()
    parse_maps(rest, Map.put(map, start, {l, r}))
  end

end

Day08.start()