with open("input.txt") as f:
    monkeys = [m.split("\n") for m in f.read().split("\n\n")]

items = []
operations = []
tests = []

bigNhelper = 1

for m in monkeys:
    newitems = []
    start = m[1].split(" ")
    for i in range(4, len(start) - 1):
        newitems.append(int(start[i][:len(start[i]) - 1]))
    newitems.append(int(start[len(start) - 1]))
    items.append(newitems)

    ops = m[2].split(" = ")
    operations.append(ops[1])

    tests.append((int(m[3].split(" by ")[1]), int(m[4].split(" monkey ")[1]), int(m[5].split(" monkey ")[1])))
    bigNhelper *= int(m[3].split(" by ")[1])

backup = [[i for i in m] for m in items]

def simulate(divide = True, rounds = 20):
    count = [0 for m in monkeys]
    for round in range(rounds):
        for id, mit in enumerate(items):

            for item in mit:
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

print(f"Part One: {simulate()}")
items = backup
print(f"Part Two: {simulate(False, 10000)}")

