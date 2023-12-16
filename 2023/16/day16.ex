defmodule Day16 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split()
    |> Stream.map(&String.graphemes/1) |> Enum.map(&List.to_tuple/1) |> List.to_tuple()
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    input
    |> step({{0,0}, {1,0}})
    |> elem(0)
    |> covered()
  end

  def step(map, beam, lookup \\ %{}) do
    case Map.get(lookup, beam) do
      nil ->
        lookup = Map.put(lookup, beam, [beam])
        {{x, y}, {xdir, ydir}} = beam
        {list, lookup} = case at(map, x, y) do
          "."  -> insert(map, {{x+xdir, y+ydir}, {xdir ,  ydir}}, lookup)
          "/"  -> insert(map, {{x-ydir, y-xdir}, {-ydir, -xdir}}, lookup)
          "\\" -> insert(map, {{x+ydir, y+xdir}, { ydir,  xdir}}, lookup)
          "|"  ->
            if xdir == 0 do
              insert(map, {{x+xdir, y+ydir}, {xdir, ydir}}, lookup)
            else
              {list1, lookup} = insert(map, {{x, y+1},{0, 1}}, lookup)
              {list2, lookup} = insert(map, {{x, y-1},{0, -1}}, lookup)
              {list1 ++ list2, lookup}
            end
          "-"  ->
            if ydir == 0 do
              insert(map, {{x+xdir, y+ydir}, {xdir, ydir}}, lookup)
            else
              {list1, lookup} = insert(map, {{x+1, y},{1, 0}}, lookup)
              {list2, lookup} = insert(map, {{x-1, y},{-1, 0}}, lookup)
              {list1 ++ list2, lookup}
            end
        end
        list = [beam | list]
        {list, Map.put(lookup, beam, list)}
      list ->
        {[beam | list], lookup}
      end
  end

  def insert(map, item, lookup) do
    {x, y} = elem(item, 0)
    if x >= tuple_size(elem(map,0)) or  x < 0 or y >= tuple_size(map) or  y < 0 do
      {[], lookup}
    else
      step(map, item, lookup)
    end
  end

  def part_2(input) do
    max(
    for y <- 0..(tuple_size(input) - 1), reduce: 0 do
      max ->
        step(input, {{0,y}, {1, 0}}) |> elem(0) |> covered()
        |> max(step(input, {{tuple_size(elem(input, 0)) - 1,y}, {-1, 0}}) |> elem(0) |> covered())
        |> max(max)
    end,
    for x <- 0..(tuple_size(elem(input, 0)) - 1), reduce: 0 do
      max ->
        step(input, {{x,0}, {0, 1}}) |> elem(0) |> covered()
        |> max(step(input, {{x,tuple_size(input) - 1}, {0, -1}}) |> elem(0) |> covered())
        |> max(max)
    end)
  end

  def covered(hist) do
    hist
    |> Stream.map(fn {{x, y}, _} -> {x,y} end)
    |> Enum.uniq()
    |> length()
  end

  def at(map, x, y) do
    map |> elem(y) |> elem(x)
  end

end

Day16.start()
