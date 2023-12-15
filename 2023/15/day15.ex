defmodule Day15 do

  def start() do
    input = File.read!("input.txt") |> String.replace("\r", "")
    IO.inspect(part_1(input), label: "Part 1: ")
    IO.inspect(part_2(input), label: "Part 2: ")
  end

  def part_1(input) do
    input |> String.split(",") |> Stream.map(&String.to_charlist/1)
    |> Stream.map(&hash/1) |> Enum.sum()
  end

  def hash(charlist, val \\ 0)
  def hash([]      , val), do: val
  def hash([c | cs], val) do
    new_val = (val + c) * 17 |> rem(256)
    hash(cs, new_val)
  end

  def part_2(input) do
    input |> String.split(",") |> hashmap(List.duplicate([], 256))
    |> Stream.with_index() |> Stream.map(fn {list, i} ->
      list |> Stream.with_index() |> Stream.map(fn {{_label, val}, j} ->
        (i+1) * (j+1) * val
      end) |> Enum.sum()
    end) |> Enum.sum()
  end

  def hashmap([]      , map), do: map
  def hashmap([c | cs], map) do
    [label, val] = String.split(c, ~r/=|-/)
    pos = hash(String.to_charlist(label))
    new_map = List.replace_at(map, pos, case val do
      "" ->
        Enum.filter(Enum.at(map, pos), fn {l, _v} -> label != l end)
      ^val ->
        bucket = Enum.at(map, pos)
        case Enum.find_index(bucket, fn {l, _v} -> l == label end) do
          nil ->
            bucket ++ [{label, String.to_integer(val)}]
          i ->
            List.replace_at(bucket, i, {label, String.to_integer(val)})
        end
    end)
    hashmap(cs, new_map)
  end

end

Day15.start()
