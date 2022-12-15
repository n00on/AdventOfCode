with open("input.txt") as f:
    input = [line.split(": closest beacon is at x=") for line in f.read().split("\n")]
    sensors = [tuple([ int(i) for i in c[0].split("x=")[1].split(", y=")]) for c in input]
    beacons = [tuple([ int(i) for i in c[1].split(", y=")]) for c in input]

def calcLine(row = 10):
    taken = set()
    for sensor, beacon in zip(sensors, beacons):
        diff = abs(sensor[1] - beacon[1]) + abs(sensor[0] - beacon[0])
        diff2row = diff - abs(sensor[1] - row)
        for x in range(sensor[0] - diff2row, sensor[0] + diff2row + 1):
            taken.add(x)

    for b in beacons:
        if b[1] == row and b[0] in taken:
            taken.remove(b[0])
    return len(taken)

def findHole(row, bound = 20):
    ranges = []
    for sensor, beacon in zip(sensors, beacons):
        diff = abs(sensor[1] - beacon[1]) + abs(sensor[0] - beacon[0])
        diff2row = diff - abs(sensor[1] - row)
        se = (max(0, sensor[0] - diff2row), min(sensor[0] + diff2row, bound))
        if se[0] <= se[1]:
            ranges.append(se)

    last = 0
    for s, e in sorted(ranges):
        if s <= last + 1:
            last = max(last, e)
        else:
            return (s-1) * bound + row
    return -1

def part2(bound = 20):
    tuning_frequency = -1
    for i in range(bound):
        tuning_frequency = findHole(i, bound)
        if tuning_frequency != -1:
            return tuning_frequency


print(f"Part One: {calcLine(2000000)}")
print(f"Part Two: {part2(4000000)}")