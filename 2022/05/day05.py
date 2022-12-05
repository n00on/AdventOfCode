with open('input.txt') as f:
    lines = f.read().split("\n\n")

startconf = lines[0].split("\n")
startconf.pop()

# Parse stack
stacks = []
for i in range(1, len(startconf[len(startconf) - 1]), 4):
    stacks.append([])

    for h in range(len(startconf) - 1, -1, -1):
        if startconf[h][i] != " ":
            stacks[len(stacks) - 1].append(startconf[h][i])

# Deep copy stack for part two
stacks9001 = []
for s in stacks:
    stacks9001.append(s.copy())

# Perform all shuffles
shuffles = [[[int(s) for s in r.split(" to ")] for r in l[5:].split(" from ")] for l in lines[1].split("\n")]
for s in shuffles:
    move = []
    for i in range(s[0][0]):
       move.append(stacks9001[s[1][0]-1].pop())
       stacks[s[1][1]-1].append(stacks[s[1][0]-1].pop())

    for i in range(s[0][0]):
        stacks9001[s[1][1]-1].append(move.pop())

# Build answers
ans = ""
ans9001 = ""
for si in range(len(stacks)):
    ans += stacks[si][len(stacks[si]) - 1]
    ans9001 += stacks9001[si][len(stacks9001[si]) - 1]

print(f"Part One: {ans}")
print(f"Part One: {ans9001}")