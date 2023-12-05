defmodule Day05 do

  def start() do
    parsed = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    #IO.puts("Part 1: " <> inspect(part_1(parsed)))
    IO.puts("Part 2: " <> inspect(part_2(parsed)))
  end

  def part_1(parsed) do
    seeds = for p <- (parsed |> hd() |> String.split() |> tl()), do: String.to_integer(p)
    funs = for p <- tl(parsed), do: parse_function(tl(String.split(p, "\n")))
    for seed <- seeds, reduce: nil do
      acc -> min(acc, get_location(seed, funs))
    end
  end

  def parse_function([]) do
    fn x -> x end
  end
  def parse_function(description) do
    [dest_start, source_start, len] = for n <- String.split(hd(description)), do: String.to_integer(n)
    next_fun = parse_function(tl(description))
    fn x ->
      if x >= source_start and x < source_start + len do
        dest_start + x - source_start
      else
        next_fun.(x)
      end
    end
  end

  def part_2(parsed) do
    funs = for p <- tl(parsed), do: parse_function(tl(String.split(p, "\n")))
    for [seed_start, seed_len] <- (parsed |> hd() |> String.split() |> tl() |> Stream.map(&String.to_integer/1) |> Stream.chunk_every(2)), reduce: nil do
      acc -> min(acc, get_min_for_range(seed_start, seed_start + seed_len - 1, funs))
    end
  end

  def get_min_for_range(seed_start, seed_end, funs) do
    for seed <- seed_start..seed_end, reduce: nil do
      acc -> min(acc, get_location(seed, funs))
    end
  end

  def get_location(seed, funs) do
    for fun <- funs, reduce: seed do
      acc -> fun.(acc)
    end
  end

end

Day05.start()
