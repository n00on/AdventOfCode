defmodule Day19 do

  def start() do
    [workflows, items] = File.read!("input.txt") |> String.replace("\r", "") |> String.split("\n\n")
    |> Enum.map(&String.split/1)
    workflows = parse_fun_map(workflows)
    IO.inspect(part_1(workflows, items), label: "Part 1: ")
    IO.inspect(part_2(workflows), label: "Part 2: ")
  end

  def parse_fun_map(workflows) do
    for workflow <- workflows, reduce: %{} do
      map ->
        [name, ins] = String.split(workflow, "{")
        Map.put(map, name, parse_workflow(ins |> String.replace("}", "") |> String.split(",")))
    end
  end

  def parse_workflow([goal]) do
    fn _, _, _, _ -> goal end
  end
  def parse_workflow([ins | is]) do
    op = if String.at(ins, 1) == "<", do: &</2, else: &>/2
    [f, threshhold, goal] = String.split(ins, ~r/<|>|:/)
    threshhold = String.to_integer(threshhold)
    parse_rest = parse_workflow(is)

    fn x, m, a, s ->
      val = case f do
        "x" -> x
        "m" -> m
        "a" -> a
        "s" -> s
      end
      if op.(val, threshhold) do
        goal
      else
        parse_rest.(x, m, a, s)
      end
    end
  end

  def part_1(workflows, items) do
    for item <- items do
      [x,m,a,s] = Regex.scan(~r/\d+/, item) |> Enum.concat() |> Enum.map(&String.to_integer/1)
      if run(workflows, "in", x,m,a,s) do
        x+m+a+s
      else
        0
      end
    end
    |> Enum.sum()

  end

  def run(_, "A", _,_,_,_), do: true
  def run(_, "R", _,_,_,_), do: false
  def run(workflows, current, x,m,a,s) do
    w = Map.get(workflows, current)
    run(workflows, w.(x,m,a,s), x,m,a,s)
  end

  def part_2(workflows) do
    for x <- 0..4000 do
      for m <- 0..4000, a <- 0..4000, s <- 0..4000, reduce: 0 do
        sum -> if run(workflows, "in", x,m,a,s) do
          sum + 1
        else
          sum
        end
      end
      |> IO.inspect()
    end |> Enum.sum()
  end

end

Day19.start()
