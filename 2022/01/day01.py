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

top3 = 0
for i in range(3):
    top3 += calories[i]


print(f"Part Two: {top3}")