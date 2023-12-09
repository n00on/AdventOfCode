defmodule Day08 do

  def start() do
    [instruct, maps]= File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    parsed_instruct = for dir <- String.graphemes(instruct) do
      if dir == "L", do: 0, else: 1
    end |> List.to_tuple()
    parsed_maps = parse_maps(String.split(maps, "\n"), %{})
    IO.puts("Part 2: " <> inspect(part_2(parsed_maps, parsed_instruct)))
  end

  def part_2(map, instruct) do
    start = Map.keys(map) |> Enum.filter(fn key -> String.ends_with?(key, "A") end) |> Enum.zip(List.duplicate(0, 100))
    go_goal(map, start, instruct, %{})
  end

  def find_goal(map, pos, instruct, step) do
    dir = elem(instruct, Integer.mod(step, tuple_size(instruct)))
    new_pos = elem(Map.get(map, pos), dir)
    if String.ends_with?(new_pos, "Z") do
      {new_pos, step + 1}
    else
      find_goal(map, new_pos, instruct, step + 1)
    end
  end

  def go_goal(map, positions, instruct, to_map) do
    # find minimum step and instruction pointer
    min = Enum.min(positions, fn {_p1, s1}, {_p2, s2} -> s1 <= s2 end)
    {min_pos, min_step} = min
    ip = Integer.mod(min_step, tuple_size(instruct))

    # find next goal for min, try in dynamic map
    {new_positions, new_to_map} = case to_map do
      %{{^min_pos, ^ip} => {new_pos, new_step}} ->
        {[{new_pos, new_step + min_step} | List.delete(positions, min)], to_map}
      _ ->
        {new_pos, new_step} = find_goal(map, min_pos, instruct, ip)
        new_to_map = Map.put(to_map, {min_pos, ip}, {new_pos, new_step - ip})
        {[{new_pos, new_step + min_step - ip} | List.delete(positions, min)], new_to_map}
    end

    # check wether finished
    all_on_same_step = length(for {_p, s} <- new_positions, uniq: true, do: s) == 1
    if all_on_same_step and Enum.all?(new_positions, fn {p, _s} -> String.ends_with?(p, "Z") end) do
      {_p, s} = hd(new_positions)
      s
    else
      go_goal(map, new_positions, instruct, new_to_map)
    end
  end

  def parse_maps([], map), do: map
  def parse_maps([map_str | rest], map) do
    [start, l, r] = map_str |> String.replace(~r/=|\(|,|\)/, "") |> String.split()
    parse_maps(rest, Map.put(map, start, {l, r}))
  end

end

Day08.start()
