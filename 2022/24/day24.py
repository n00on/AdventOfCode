with open("input.txt") as f:
    initial = f.read().split("\n")

height = len(initial)
width = len(initial[0])

directions = ((1,0), (0,1), (-1,0), (0,-1), (0,0))

start = (0,1)
goal = (height - 1, width - 2)

def calcTripTime(start : (int), goal : (int), minute = 0) -> int:
    pos = set([start])
    while goal not in pos:
        minute += 1
        board = getBoard(minute)
        pos = getNextPositions(pos, board)
    return minute

def getBoard(i : int) -> list[list[bool]]:
    board = [[tile == '#' for tile in row] for row in initial]

    for y in range(1, height-1):
        for x in range(1, width-1):
            tile = initial[y][x]
            if tile == '.':
                continue
            yi, xi = getBlizzardPosition(i, x, y, tile)
            board[yi][xi] = True
    return board

def getBlizzardPosition(i : int, x : int, y : int, dir : str) -> (int):
    match dir:
        case '>':
            x = (x-1 + i) % (width -2) + 1
        case 'v':
            y = (y-1 + i) % (height-2) + 1
        case '<':
            x = (x-1 - i) % (width -2) + 1
        case '^':
            y = (y-1 - i) % (height-2) + 1
    return y, x

def getNextPositions(pos : list[(int)], board : list[list[bool]]) -> set[(int)]:
    nextpos = set()
    for y, x in pos:
        for yd, xd in directions:
            yt, xt = y+yd, x+xd
            if 0 <= yt < height and 0 <= xt < width and not board[yt][xt]:
                nextpos.add((yt, xt))
    return nextpos

def printMap(map : list[list[bool]]) -> None:
    for row in map:
        line = "".join(['#' if tile else '.' for tile in row])
        print(line)
    print()

minutes = calcTripTime(start, goal)
print(f"Part One: {minutes}")

minutes = calcTripTime(goal, start, minutes)
minutes = calcTripTime(start, goal, minutes)
print(f"Part Two: {minutes}")