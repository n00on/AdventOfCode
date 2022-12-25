with open("input.txt") as f:
    initial = f.read().split("\n")

height = len(initial)
width = len(initial[0])

directions = [(1,0), (0,1), (-1,0), (0,-1), (0,0)]

start = (0,1)
goal = (height - 1, width - 2)

def printMap(map : list[list[bool]]) -> None:
    for row in map:
        line = ""
        for tile in row:
            line += '#' if tile else '.'
        print(line)
    print()

def getBoard(i : int) -> list[list[bool]]:
    board = [[tile == '#' for tile in row] for row in initial]

    for y in range(1, height-1):
        for x in range(1, width-1):
            tile = initial[y][x]
            if tile == '.':
                continue
            yi, xi = y, x
            match tile:
                case '>':
                    xi = (x-1 + i) % (width -2) + 1
                case 'v':
                    yi = (y-1 + i) % (height-2) + 1
                case '<':
                    xi = (x-1 - i) % (width -2) + 1
                case '^':
                    yi = (y-1 - i) % (height-2) + 1
            board[yi][xi] = True
    return board

def getTrip(start : (int), goal : (int), minute = 0) -> int:
    pos = set([start])
    while goal not in pos:
        minute += 1
        board = getBoard(minute)

        nextpos = set()
        for y, x in pos:
            for yd, xd in directions:
                yt, xt = y+yd, x+xd
                if 0 <= yt < height and 0 <= xt < width and not board[yt][xt]:
                    nextpos.add((yt, xt))
        
        pos = nextpos
    return minute

minutes = getTrip(start, goal)
print(f"Part One: {minutes}")

minutes = getTrip(goal, start, minutes)
minutes = getTrip(start, goal, minutes)
print(f"Part Two: {minutes}")