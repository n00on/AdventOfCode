defmodule Day05 do

  def start() do
    [seed_line | mappings] = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    mapping_funs = for m <- mappings, do: parse_mapping(tl(String.split(m, "\n")))
    IO.puts("Part 1: " <> inspect(part_1(seed_line, mapping_funs)))
    IO.puts("Part 2: " <> inspect(part_2(seed_line, mapping_funs)))
  end

  def part_1(seed_line, mappings) do
    seeds = for p <- (seed_line |> String.split() |> tl()), do: String.to_integer(p)
    for seed <- seeds, reduce: nil do
      acc -> min(acc, get_location(seed, mappings))
    end
  end

  defp parse_mapping([]), do: &Function.identity/1
  defp parse_mapping([range_str | rest]) do
    [dest_start, source_start, len] = for n <- String.split(range_str), do: String.to_integer(n)
    next_mapping = parse_mapping(rest)
    fn # checks for all mapping ranges, then identity
      x when x >= source_start and x < source_start + len ->
        dest_start - source_start + x
      x ->
        next_mapping.(x)
    end
  end

  def part_2(seed_line, mappings) do
    for [seed_start, seed_len] <-
        (seed_line |> String.split() |> tl() |> Stream.map(&String.to_integer/1) |> Stream.chunk_every(2)),
        reduce: nil do
      val -> min(val, get_min_for_range(seed_start, seed_start + seed_len - 1, mappings))
    end
  end

  defp get_min_for_range(seed_start, seed_end, mappings) do
    for seed <- seed_start..seed_end, reduce: nil do
      val -> min(val, get_location(seed, mappings))
    end
  end

  defp get_location(seed, mappings) do
    for mapping <- mappings, reduce: seed do
      val -> mapping.(val)
    end
  end

end

Day05.start()
