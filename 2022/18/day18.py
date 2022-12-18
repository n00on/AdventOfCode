import sys

with open("input.txt") as f:
    # add 1 buffer for handling edges
    input = [[int(c) + 1 for c in p.split(",")] for p in f.read().split("\n")]

n = max([max(l) for l in input]) + 2
r = range(n)
sys.setrecursionlimit(n**3)

droplets = [[[False for _ in r]for _ in r] for _ in r]
for x,y,z in input:
    droplets[x][y][z] = True

directions = [(0,0,1), (0,1,0), (1,0,0), (0,0,-1), (0,-1,0), (-1,0,0)]

def part1() -> int:
    count = 0
    for x in range(1,n-1):
        for y in range(1,n-1):
            for z in range(1,n-1):
                if not droplets[x][y][z]:
                    continue
                for xd, yd, zd in directions:
                    x1, y1, z1 = x+xd, y+yd, z+zd
                    if not droplets[x1][y1][z1]:
                        count += 1
    return count

visited = [[[False for _ in r]for _ in r]for _ in r]

def part2(x,y,z) -> int:
    count = 0
    visited[x][y][z] = True
    for xd,yd,zd in directions:
        x1, y1, z1 = x+xd, y+yd, z+zd
        if x1 in r and y1 in r and z1 in r:
            if droplets[x1][y1][z1]:
                count += 1
            elif not visited[x1][y1][z1]:
                count += part2(x1,y1,z1)
    return count

print(f"Part One: {part1()}")
print(f"Part Two: {part2(0,0,0)}")