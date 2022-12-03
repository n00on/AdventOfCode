with open("input.txt") as f:
    rations = f.read().split("\n\n")

calories = []

for r in rations:
    next = 0
    for food in r.split("\n"):
        next += int(food)
    calories.append(next)

calories.sort(reverse = True)

print(f"Part One: {calories[0]}")

print(f"Part Two: {sum(calories[:3])}")