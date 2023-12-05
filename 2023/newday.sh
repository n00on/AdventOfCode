#!/bin/bash

day="${1:-$(date +%d)}"

program="defmodule Day$day do
  
  def start() do
    parsed = File.read!(\"input.txt\") |> String.replace(\"\r\", \"\") |> String.split()
    IO.puts(\"Part 1: \" <> inspect(part_1(parsed)))
    IO.puts(\"Part 2: \" <> inspect(part_2(parsed)))
  end

  def part_1(parsed) do
    :ok
  end

  def part_2(parsed) do
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
