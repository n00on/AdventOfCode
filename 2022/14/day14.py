with open("input.txt") as f:
    input = f.read().split("\n")

start = (500, 0)
rock = set()

max_rock = 0
for path in input:
    points = path.split(" -> ")
    for i in range(len(points) - 1):
        s = [int(c) for c in points[i].split(",")]
        e = [int(c) for c in points[i + 1].split(",")]

        dir = (e[0] - s[0], e[1] - s[1])
        dir = [0 if d == 0 else d / abs(d) for d in dir]

        x = s[0]
        y = s[1]
        while x != e[0] or y != e[1]:
            rock.add((x,y))
            x += dir[0]
            y += dir[1]
            max_rock = y if y > max_rock else max_rock
        rock.add((x,y))

def simulate(rock : set) -> int:
    count = 0
    while(True):
        sand = start
        moved = True
        while (moved):
            moved = False
            for dirx, diry in [(0,1), (-1,1), (1,1)]:
                next = (sand[0] + dirx, sand[1] + diry)
                if next not in rock:
                    moved = True
                    sand = next
                    break
            if sand[1] > max_rock + 1:
                return count
        count += 1
        rock.add(sand)
        if sand == start:
            return count

part1 = simulate(rock)
print(f"Part One: {part1}")

# Profit off of results from Part One
for x in range(int(500 - max_rock * 2), int(500 + max_rock * 2)):
    rock.add((x, max_rock + 2))
print(f"Part Two: {part1 + simulate(rock)}")