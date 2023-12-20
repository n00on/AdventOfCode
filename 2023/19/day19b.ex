defmodule Day19 do

  def start() do
    [workflows, _items] = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    |> Enum.map(&String.split/1)
    workflows = parse_fun_map(workflows)
    IO.inspect(part_2(workflows), label: "Part 2: ")
  end

  def parse_fun_map(workflows) do
    for workflow <- workflows, reduce: %{} do
      map ->
        [name, ins] = String.split(workflow, "{")
        Map.put(map, name, ins |> String.replace("}", "") |> String.split(","))
    end
  end

  def part_2(workflows) do
    get_accepted(workflows, "in", %{"x" => 1..4000, "m" => 1..4000, "a" => 1..4000, "s" => 1..4000})
  end

  def get_accepted(_, "A", ranges), do: ranges |> Map.values() |> Stream.map(&Range.size/1) |> Enum.product()
  def get_accepted(_, "R", _), do: 0
  def get_accepted(workflows, status, ranges) do
    for_workflow(workflows, Map.get(workflows, status), ranges)
  end

  def for_workflow(workflows, [goal], ranges), do: get_accepted(workflows, goal, ranges)
  def for_workflow(workflows, [ins | is], ranges) do
    [<<f::utf8, op::utf8>> <> threshhold, goal] = String.split(ins, ":")
    f = <<f>>
    op = <<op>>
    threshhold = threshhold |> String.to_integer()

    frange = Map.get(ranges, f)
    IO.inspect({f, frange})
    if threshhold in frange do
      if op == "<" do
        {range1, range2} = Range.split(frange, threshhold - frange.first) |> IO.inspect()
        get_accepted(workflows, goal, Map.put(ranges, f, range1)) + for_workflow(workflows, is, Map.put(ranges, f, range2))
      else
        {range1, range2} = Range.split(frange, threshhold - frange.first + 1) |> IO.inspect()
        get_accepted(workflows, goal, Map.put(ranges, f, range2)) + for_workflow(workflows, is, Map.put(ranges, f, range1))
      end
    else
      for_workflow(workflows, is, ranges)
    end
  end

end

Day19.start()
