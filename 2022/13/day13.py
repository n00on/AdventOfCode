with open("input.txt") as f:
    pairs = [eval(p) for p in f.read().split("\n") if p != '']

def compare(left, right):
    if isinstance(left, int):
        if isinstance(right, int):
            return left - right
        return compare([left], right)

    if isinstance(right, int):
        return compare(left, [right])

    for j in range(len(left)):
        if j >= len(right):
            return 1
        c = compare(left[j], right[j])
        if c != 0:
            return c
    return len(left) - len(right)

sum = 0
for i in range(0, len(pairs), 2):
    if compare(pairs[i], pairs[i+1]) <= 0:
        sum += (i//2) + 1

print(f"Part One: {sum}")