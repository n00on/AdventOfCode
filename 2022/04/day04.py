with open("input.txt") as f:
    ranges = [[[int(i) for i in range.split("-")] for range in pair.split(",")] for pair in f.read().split("\n")]

countFullOverlaps = 0
countOverlaps = 0

for r in ranges:
    if r[0][0] >= r[1][0] and r[0][1] <= r[1][1] or r[0][0] <= r[1][0] and r[0][1] >= r[1][1]:
        countFullOverlaps += 1
    if r[1][0] <= r[0][1] and r[0][0] <= r[1][1]:
        countOverlaps += 1

print(f"Part One: {countFullOverlaps}")
print(f"Part Two: {countOverlaps}")