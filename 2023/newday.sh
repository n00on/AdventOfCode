#/bin/bash

day="${1:-$(date +%d)}"
mkdir "$day";
cd "$day";
echo "defmodule Day$day do
  
  def read() do
    parsed = File.read!("input.txt") |> String.split()
    IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(parsed) do
    :ok
  end

  def part_2(parsed) do
    :ok
  end

end

Day$day.read()
" > "day$day.ex";
touch "input.txt";

echo "Created Day$day"