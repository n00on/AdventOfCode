with open("input.txt") as f:
    initial = f.read().split("\n")

# NOT SUITABLE FOR HUGE SEARCH SPACE

height = len(initial)
width = len(initial[0])

directions = ((1,0), (0,1), (0,0), (-1,0), (0,-1))

def printMap(map : list[list[bool]]) -> None:
    for row in map:
        line = ""
        for tile in row:
            line += '#' if tile else '.'
        print(line)
    print()

boards = [None]
def getBoard(i : int) -> list[list[bool]]:
    if i < len(boards) and boards[i] != None:
        return boards[i]
    
    board = [[tile == '#' for tile in row] for row in initial]
    board[0][1] = True

    for y in range(1, height-1):
        for x in range(1, width-1):
            tile = initial[y][x]
            if tile == '.':
                continue
            yi, xi = y, x
            match tile:
                case '>':
                    xi = (x-1 + i) % (width-2) + 1
                case 'v':
                    yi = (y-1 + i) % (height-2) + 1
                case '<':
                    xi = (x-1 - i) % (width-2) + 1
                case '^':
                    yi = (y-1 - i) % (height-2) + 1
            board[yi][xi] = True
    boards.insert(i, board)
    return board


pos = [(0, 1)]
goal = (height - 1, width - 2)

minDepth = 1000
dirpointers = [0]
while len(pos) > 0:
#for _ in range(10):
    depth = len(pos) - 1
    end = pos[depth] == goal
    if end or dirpointers[depth] > 4 or minDepth <= depth:
        pos.pop()
        dirpointers.pop()
        if end:
            minDepth = depth
            print(depth)
        continue
    
    board = getBoard(depth + 1)
    #print(f"{depth}  {pos[depth]}")
    #printMap(board)

    y, x = pos[depth]
    yd, xd = directions[dirpointers[depth]]
    if not board[y+yd][x+xd]:
        pos.append((y+yd, x+xd))
        dirpointers.append(0)
    
    dirpointers[depth] += 1

print(minDepth)
