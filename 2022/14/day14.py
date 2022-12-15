with open("input.txt") as f:
    input = f.read().split("\n")

source = (500, 0)
rock = set()

def sgn(i : int) -> int:
    return i // abs(i) if i != 0 else 0

max_rock = 0
for path in input:
    points = path.split(" -> ")
    start = tuple([int(c) for c in points[0].split(",")])
    for i in range(1, len(points)):
        end = tuple([int(c) for c in points[i].split(",")])
        dir = (sgn(end[0] - start[0]), sgn(end[1] - start[1]))
    
        x = start[0]
        y = start[1]
        while (x, y) != end:
            rock.add((x, y))
            x += dir[0]
            y += dir[1]
            max_rock = max(y, max_rock)
        rock.add((x, y))
        start = end

def simulate(rock : set) -> int:
    count = 0
    while(True):
        sand = move_sand(rock)
        if sand[1] > max_rock:
            return count # sand fell into the void
        count += 1
        rock.add(sand)
        if sand == source:
            return count # sand blocks the source

def move_sand(rock : set) -> (int):
    sand = source
    moved = True
    while (moved):
        moved = False
        for dirx, diry in [(0,1), (-1,1), (1,1)]:
            next = (sand[0] + dirx, sand[1] + diry)
            if next not in rock:
                moved = True
                sand = next
                break
        if sand[1] > max_rock:
            return sand
    return sand

part1 = simulate(rock)
print(f"Part One: {part1}")

max_rock += 2
# Profit off of results from Part One
for x in range(source[0] - max_rock - 1, source[0] + max_rock + 1):
    rock.add((x, max_rock))
print(f"Part Two: {part1 + simulate(rock)}")