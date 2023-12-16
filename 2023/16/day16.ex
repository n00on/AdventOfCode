defmodule Day16 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "") |> String.split()
    |> Stream.map(&String.graphemes/1) |> Enum.map(&List.to_tuple/1) |> List.to_tuple()
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    run(input, [{{0,0}, {1,0}}])
    |> Stream.map(fn {{x, y}, _} -> {x,y} end)
    |> Stream.filter(fn {x,y} -> x >= 0 and y >= 0
        and x < tuple_size(elem(input, 0)) and y < tuple_size(input) end)
    |> Enum.uniq() #|> IO.inspect()
    |> length()
  end

  def run(map, beams, hist \\ []) do
    if Enum.all?(beams, fn beam -> beam in hist end) do
      hist
    else
      new_beams = Stream.map(beams, fn beam -> step(map, beam) end) |> Stream.concat() |> Enum.uniq()
      run(map, new_beams, beams ++ hist)
    end
  end

  def step(map, {{x, _}, _}) when x >= tuple_size(elem(map,0)) or  x < 0, do: []
  def step(map, {{_, y}, _}) when y >= tuple_size(map) or  y < 0, do: []
  def step(map, {{x, y}, {xdir, ydir}}) do
    case at(map, x, y) do
      "."  -> [{{x+xdir, y+ydir}, {xdir ,  ydir}}]
      "/"  -> [{{x-ydir, y-xdir}, {-ydir, -xdir}}]
      "\\" -> [{{x+ydir, y+xdir}, { ydir,  xdir}}]
      "|"  ->
        if xdir == 0 do
          [{{x+xdir, y+ydir}, {xdir, ydir}}]
        else
          [{{x, y+1},{0, 1}}, {{x, y-1},{0, -1}}]
        end
      "-"  ->
        if ydir == 0 do
          [{{x+xdir, y+ydir}, {xdir, ydir}}]
        else
          [{{x+1, y},{1, 0}}, {{x-1, y},{-1, 0}}]
        end
    end
  end

  def part_2(input) do
    :ok
  end

  def at(map, x, y) do
    map |> elem(y) |> elem(x)
  end

end

Day16.start()
