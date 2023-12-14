with open("input.txt") as f:
    ranges = [[[int(i) for i in range.split("-")] for range in pair.split(",")] for pair in f.read().split("\n")]

fullOverlaps = 0
overlaps = 0

for r in ranges:
    if r[0][0] >= r[1][0] and r[0][1] <= r[1][1] or r[0][0] <= r[1][0] and r[0][1] >= r[1][1]:
        fullOverlaps += 1
    if r[1][0] <= r[0][1] and r[0][0] <= r[1][1] or r[0][1] <= r[1][0] and r[1][1] <= r[0][0]:
        overlaps += 1

print(f"Part One: {fullOverlaps}")
print(f"Part Two: {overlaps}")