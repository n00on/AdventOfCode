with open("input.txt") as f:
    opcodes = f.read().split("\n")

cycle = 0
ip = 0
X = 1

acc = 0
add = False
V = 0

crtp = 0
crt = [[False for j in range(40)] for i in range(6)]

while cycle < 240:
    cycle += 1

    if (cycle - 20) % 40 == 0:
        acc += (cycle) * X

    if crtp % 40 in [X-1, X, X+1]:
        crt[crtp // 40][crtp % 40] = True

    if add:
        X += V
        add = False
    elif ip < len(opcodes):
        match opcodes[ip].split(" "):
            case ["noop"]:
                pass
            case ["addx", v]:
                add = True
                V = int(v)
        ip += 1
    crtp += 1

print(f"Part One: {acc}")

s = ""
for y in range(6):
    for x in range(40):
        if crt[y][x]:
            s += '#'
        else: 
            s += '.'
    s += '\n'

print(f"Part Two:\n{s}")