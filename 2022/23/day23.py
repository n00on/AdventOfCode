with open("input.txt") as f:
    input = [[tile == '#' for tile in row] for row in f.read().split("\n")]

directions = {'N':(-1, 0), 'NE':(-1,1), 'E':(0,1), 'SE':(1,1), 'S':(1,0), 'SW':(1,-1), 'W':(0,-1), 'NW':(-1,-1)}

elvdir = ['N', 'S', 'W', 'E']
elvdirpoint = 0

N = 10

height = len(input)
width = len(input[0])

for i in range(N):
    input.insert(0, [False] * width)
    input.append([False] * width)

buffer = [False] * N
for i, row in enumerate(input):
    input[i] = buffer + row + buffer

height += N*2
width += N*2

#for row in input:
#    print(row)

def checkAdjacent(y,x) -> dict:
    dirs = {'N':0, 'S': 0, 'W':0, 'E':0}
    for key in directions:
        yd, xd = directions[key]
        if input[y+yd][x+xd]:
            dirs[key[0]] += 1
    return dirs

for _ in range(N):
    plan = [[' ' for p in row] for row in input]
    for y, row in enumerate(input):
        if y == 0 or y == height-1:
            continue
        for x, p in enumerate(row):
            if x == 0 or x == width-1:
                continue
            viable = checkAdjacent(y,x)
            if sum(viable.values()) == 0:
                continue
            for i in range(4):
                dir = elvdir[(elvdirpoint + i) % len(elvdir)]
                if viable[dir] == 0:
                    yd, xd = directions[dir]
                    if plan[y+yd][x+xd] == ' ':
                        plan[y+yd][x+xd] = dir
                    else:
                        plan[y+yd][x+xd] = 'X'
                    break
    newmap = [[p for p in row] for row in input]
    for y, row in enumerate(plan):
        for x, p in enumerate(row):
            if p == 'X' or p == ' ':
                continue
            newmap[y][x] = True
            yd, xd = directions[p]
            newmap[y-yd][x-xd] = False
    input = newmap
    elvdirpoint = (elvdirpoint + 1) % len(elvdir)


startx = width
endx = 0
starty = height
endy = 0

for y, row in enumerate(input):
    for x, p in enumerate(row):
        if p:
            startx = min(startx,x)
            starty = min(starty,y)
            endx = max(endx,x + 1)
            endy = max(endy,y + 1)

sum = 0
for y in range(starty, endy):
    for x in range(startx, endx):
        if not input[y][x]:
            sum += 1

print(sum)