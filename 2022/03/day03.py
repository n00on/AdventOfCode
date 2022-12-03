with open("input.txt") as f:
    rucksacks = f.readlines()

def getScore(c):
    if ord(c) <= ord('Z'):
        return ord(c) - ord('A') + 27
    else:
        return ord(c) - ord('a') + 1

score = 0
for r in rucksacks:
    n = len(r)//2
    for c in r[:n]:      
        if c in r[n:]:
            score += getScore(c)
            break

print(f"Part One: {score}")

score = 0
for groupstart in range(0, len(rucksacks), 3):
    group = rucksacks[groupstart : groupstart + 3]
    for c in group[0]:
        if c in group[1] and c in group[2]:
            score += getScore(c)
            break

print(f"Part Two: {score}")