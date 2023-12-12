#!/bin/bash

day="${1:-$(date +%d)}"

program="defmodule Day$day do
  
  def start() do
    input = File.read!(\"input.txt\") |> String.replace(\"\r\", \"\") |> String.split()
    IO.inspect(part_1(input), label: \"Part 1: \")
    IO.inspect(part_2(input), label: \"Part 2: \")
  end

  def part_1(input) do
    :ok
  end

  def part_2(input) do
    :ok
  end

end

Day$day.start()
"

if [[ -d "$day" ]]; then
  cd "$day";
else
  mkdir "$day";
  cd "$day";
  echo "$program" >> "day$day.ex";
  echo "Created Day$day";
fi

touch "input.txt";
