with open("input.txt") as f:
    input = [[int(c) + 1 for c in p.split(",")] for p in f.read().split("\n")]

droplets = [[[False for _ in range(23)]for _ in range(23)]for _ in range(23)]

for x,y,z in input:
    droplets[x][y][z] = True

count = 0

for x in range(1,22):
    for y in range(1,22):
        for z in range(1,22):
            if not droplets[x][y][z]:
                continue
            for xd, yd, zd in [(0,0,1), (0,1,0), (1,0,0), (0,0,-1), (0,-1,0), (-1,0,0)]:
                x1, y1, z1 = x+xd, y+yd, z+zd
                if not droplets[x1][y1][z1]:
                    count += 1

print(count)