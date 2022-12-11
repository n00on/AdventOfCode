with open("input.txt") as f:
    monkeys = [m.split("\n") for m in f.read().split("\n\n")]

items = []
operations = []
tests = []
bigNhelper = 1

for m in monkeys:
    items.append([int(w) for w in m[1].split(": ")[1].split(", ")])

    operations.append(m[2].split(" = ")[1])

    # (divisor, idTrue, idFalse)
    tests.append((int(m[3].split(" by ")[1]), int(m[4].split(" monkey ")[1]), int(m[5].split(" monkey ")[1])))
    bigNhelper *= int(m[3].split(" by ")[1])

def worry(divide = True, rounds = 20):
    count = [0 for _ in monkeys]
    for _ in range(rounds):
        for id, mitems in enumerate(items):
            for item in mitems:
                count[id] += 1
                old = item
                item = eval(operations[id])
                if divide:
                    item //= 3
                else:
                    item %= bigNhelper

                if item % tests[id][0] == 0:
                    items[tests[id][1]].append(item)
                else:
                    items[tests[id][2]].append(item)

            items[id] = []

    count.sort(reverse = True)
    return count[0]*count[1]

backup = [[i for i in m] for m in items]
print(f"Part One: {worry()}")


items = backup
print(f"Part Two: {worry(False, 10000)}")