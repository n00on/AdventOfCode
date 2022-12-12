with open("input.txt") as f:
    input = f.read().split("\n")

width = len(input[0])
height = len(input)

xgoal = 0
ygoal = 0

heightmap = []
q = []
dist = [[width * height for x in range(width)] for y in range(height)]

for y1 in range(height):
    line = []
    for x1 in range(width):
        q.append((x1, y1))

        if input[y1][x1] == 'S':
            dist[y1][x1] = 0
            line.append(0)
        elif input[y1][x1] == 'E':
            xgoal = x1
            ygoal = y1
            line.append(ord('z') - ord('a'))
        else: 
            line.append(ord(input[y1][x1]) - ord('a'))
    heightmap.append(line)

def djikstra(q, dist):
    while len(q) > 0:
        minx = q[0][0]
        miny = q[0][1]
        for x1, y1 in q:
            if dist[y1][x1] < dist[miny][minx]:
                minx = x1
                miny = y1

        q.remove((minx, miny))

        for dirx, diry in [(1,0), (0,1), (-1,0), (0,-1)]:
            x1 = minx + dirx
            y1 = miny + diry
            if (x1, y1) not in q:
                continue
            alt = dist[miny][minx] + 1

            if heightmap[y1][x1] <= heightmap[miny][minx] + 1 and alt < dist[y1][x1]:
                dist[y1][x1] = alt
    return dist[ygoal][xgoal]

print(f"Part One: {djikstra([(x,y) for x,y in q], [[d for d in l] for l in dist])}")
print(f"Part One: {djikstra([(x,y) for x,y in q], [[0 if d == 0 else width*height for d in l] for l in heightmap])}")