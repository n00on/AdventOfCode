defmodule Day06 do

  def start() do
    [time_str, distance_str] = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n")
    IO.puts("Part 1: " <> inspect(part_1(time_str, distance_str)))
    IO.puts("Part 2: " <> inspect(part_2(time_str, distance_str)))
  end

  def part_1(time_str, distance_str) do
    times = time_str |> String.split() |> tl() |> Stream.map(&String.to_integer/1)
    distances = distance_str |> String.split() |> tl() |> Stream.map(&String.to_integer/1)
    for {t, d} <- Stream.zip(times, distances), reduce: 1 do
      acc -> acc * ways_to_beat_record(t, d)
    end
  end

  def ways_to_beat_record(time, distance) do
    # use quadratic formula to find interval in which we perform better than record
    # a = (-1); b = time; c = (-distance)
    shared = :math.sqrt(time*time - 4*distance)
    i_start = floor((-time + shared) / (-2)) + 1
    i_end = ceil((-time - shared) / (-2))
    i_end - i_start
  end

  def part_2(time_str, distance_str) do
    time = time_str |> String.split(":") |> Enum.at(1) |> String.replace(" ", "") |> String.to_integer()
    distance = distance_str |> String.split(":") |> Enum.at(1) |> String.replace(" ", "") |> String.to_integer()
    ways_to_beat_record(time, distance)
  end

end

Day06.start()
