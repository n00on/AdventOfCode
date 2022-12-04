with open("input.txt") as f:
    ranges = [[[int(i) for i in r.split("-")] for r in l.split(",")] for l in f.read().split("\n")]

countFull = 0
count = 0

for r in ranges:
    if r[0][0] >= r[1][0] and r[0][1] <= r[1][1] or r[0][0] <= r[1][0] and r[0][1] >= r[1][1]:
        countFull += 1
        count += 1
    elif r[0][1] >= r[1][0] and r[1][1] >= r[0][0]:
        count += 1

print(f"Part One: {countFull}")
print(f"Part Two: {count}")