#/bin/bash

day="${1:-$(date +%d)}"
mkdir "$day";
cd "$day";
echo "defmodule Day$day do
  
  def read() do
      case File.read(\"input.txt\") do
      {:ok, binary} ->
        parsed = String.split(binary)
        IO.puts(\"Part 1: #{part_1(parsed)}\")
        IO.puts(\"Part 2: #{part_2(parsed)}\")
      {:error, reason} ->
        IO.puts(reason)
    end
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