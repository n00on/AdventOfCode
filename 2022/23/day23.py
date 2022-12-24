with open("input.txt") as f:
    # True for elv
    elves = [[tile == '#' for tile in row] for row in f.read().split("\n")]

directions = {'N':(-1, 0), 'NE':(-1,1), 'E':(0,1), 'SE':(1,1), 'S':(1,0), 'SW':(1,-1), 'W':(0,-1), 'NW':(-1,-1)}
elvdir = ['N', 'S', 'W', 'E']

elvdirpoint = 0
height = len(elves)
width = len(elves[0])

def countelves(map : list[list[bool]]) -> int:
    return sum([sum([1 if tile else 0 for tile in row]) for row in map])

def printMap(map : list[list[bool]]) -> None:
    for row in map:
        line = ""
        for tile in row:
            line += '#' if tile else '.'
        print(line)
    print()

def buffer(map : list[list], n, s, w, e) -> None:
    wid = len(map[0])
    if n:
        map.insert(0, [False for _ in range(wid)])
    if s:
        map.append([False for _ in range(wid)])
    h = len(map)
    if w:
        for y in range(h):
            map[y].insert(0, False)
    if e:
        for y in range(h):
            map[y].append(False)

def checkAdjacent(y : int, x : int) -> dict:
    dirs = {'N':0, 'S': 0, 'W':0, 'E':0}
    for key in directions:
        yd, xd = directions[key]
        if elves[y+yd][x+xd]:
            dirs[key[0]] += 1
            if len(key) > 1:
                dirs[key[1]] += 1
    return dirs

def updatePlan(plan : list[str], adj : dict) -> bool:
    for i in range(4):
        dir = elvdir[(elvdirpoint + i) % len(elvdir)]
        if adj[dir] == 0:
            yd, xd = directions[dir]
            if plan[y+yd][x+xd] == ' ':
                plan[y+yd][x+xd] = dir
            else:
                plan[y+yd][x+xd] = 'X'
            return True
    return False

# buffer all sides
buffer(elves, True, True, True, True)
height = len(elves)
width = len(elves[0])

rounds = 0
moved = True
while moved:
    #printMap(elves)
    rounds += 1
    moved = False

    # Plan actions
    # Space for free, X for blocked, direction for an incoming elv with that direction
    plan = [[' ' for _ in row] for row in elves]
    for y, row in enumerate(elves):
        for x, elv in enumerate(row):
            if not elv:
                continue
            adj = checkAdjacent(y,x)
            if sum(adj.values()) == 0:
                continue
            updatePlan(plan, adj)
    
    # Execute actions
    nb, sb, wb, eb = False, False, False, False
    for y, row in enumerate(plan):
        for x, proposal in enumerate(row):
            if proposal == 'X' or proposal == ' ':
                continue
            moved = True
            elves[y][x] = True
            yd, xd = directions[proposal]
            elves[y-yd][x-xd] = False
            # decide if we need buffering
            nb = nb or y == 0
            sb = sb or y == height - 1
            wb = wb or x == 0
            eb = eb or x == width - 1
    
    buffer(elves, nb, sb, wb, eb)
    height = len(elves)
    width = len(elves[0])
    elvdirpoint = (elvdirpoint + 1) % len(elvdir)
    
    if rounds == 10:
        print(f"Part One: {(width-2)*(height-2) - countelves(elves)}")


print(f"Part Two: {rounds}")