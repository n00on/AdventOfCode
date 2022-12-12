with open("input.txt") as f:
    input = f.read().split("\n")

width = len(input[0])
height = len(input)

start = (0, 0)
goal = (0, 0)
heightmap = []
for y in range(height):
    line = []
    for x in range(width):
        if input[y][x] == 'S':
            start = (x, y)
            line.append(0)
        elif input[y][x] == 'E':
            goal = (x, y)
            line.append(ord('z') - ord('a'))
        else: 
            line.append(ord(input[y][x]) - ord('a'))
    heightmap.append(line)


def djikstra(dist):
    q = [(x,y) for x in range(width) for y in range(height)]
    while len(q) > 0:
        min = (q[0][0], q[0][1])
        for x, y in q:
            if dist[y][x] < dist[min[1]][min[0]]:
                min = (x, y)

        q.remove((min[0], min[1]))

        alt = dist[min[1]][min[0]] + 1
        for dirx, diry in [(1,0), (0,1), (-1,0), (0,-1)]:
            x, y = min[0] + dirx, min[1] + diry
            if (x, y) in q and heightmap[y][x] <= heightmap[min[1]][min[0]] + 1 and alt < dist[y][x]:
                dist[y][x] = alt

    return dist[goal[1]][goal[0]]


print(f"Part One: {djikstra([[0 if c == 'S' else width * height for c in row] for row in input])}")
print(f"Part Two: {djikstra([[0 if h == 0 else width*height for h in row] for row in heightmap])}")