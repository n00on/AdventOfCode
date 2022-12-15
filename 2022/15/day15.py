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


print(calcLine(2000000))