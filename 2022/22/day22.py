with open("input.txt") as f:
    input = f.read().split("\n\n")

N = 50
cube = False

board = input[0].split("\n")
maxWidth = max([len(row) for row in board])
maxHeight = len(board)
directions = ((0,1), (1,0), (0,-1), (-1,0)) # (y,x)
instructions = []
#print(re.split(r"(\d+)", input[1])[1:-1])

# parse instructions
num = ""
for c in input[1]:
    if ord('0') <= ord(c) <= ord('9'):
        num += c
    else:
        instructions.append(int(num))
        instructions.append(c)
        num = ""
if num != "":
    instructions.append(int(num))

# Add buffer
for y in range(maxHeight):
    board[y] += ' ' * (maxWidth - len(board[y]))

def getNextPosAndDir(pos : (int), dir : (int), n : int) -> (int):
    for i in range(n):
        nextpos = ((pos[0] + dir[0]) % maxHeight, (pos[1] + dir[1]) % maxWidth)
        next = board[nextpos[0]][nextpos[1]]
        nextdir = dir
        if next == ' ':
            if cube:
                nextpos, nextdir = wrapCube(pos, dir)
            else:
                while next == ' ':
                    nextpos = ((nextpos[0] + dir[0]) % maxHeight, (nextpos[1] + dir[1]) % maxWidth)
                    next = board[nextpos[0]][nextpos[1]]
        
        next = board[nextpos[0]][nextpos[1]]
        
        if next == '.':
            pos = nextpos
            dir = nextdir
        elif next == '#':
            return (pos, dir)
        else: 
            print(f"ERR {nextpos}  {next}")
    return (pos, dir)

# Ugly hardcoded cube form
def wrapCube(pos : (int), dir : (int)):
    if dir == (0,1):
        p = pos[0] % N
        match pos[0] // N:
            case 0:
                pos = (3*N - 1 - p, 2*N -1)
                dir = (0, -1)
            case 1:
                pos = (N - 1, 2*N + p)
                dir = (-1, 0)
            case 2:
                pos = (N - 1 - p, 3*N - 1)
                dir = (0, -1)
            case 3:
                pos = (3*N - 1, N + p)
                dir = (-1, 0)
    elif dir == (-1,0):
        p = pos[1] % N
        match pos[1] // N:
            case 0:
                pos = (N + p, N)
                dir = (0, 1)
            case 1:
                pos = (3*N + p, 0)
                dir = (0, 1)
            case 2:
                pos = (4*N - 1, p)
                dir = (-1, 0)
    elif dir == (0,-1):
        p = pos[0] % N
        match pos[0] // N:
            case 0:
                pos = (3*N - 1 - p, 0)
                dir = (0, 1)
            case 1:
                pos = (2*N, p)
                dir = (1, 0)
            case 2:
                pos = (N - 1 - p, N)
                dir = (0, 1)
            case 3:
                pos = (0, N + p)
                dir = (1, 0)
    elif dir == (1, 0):
        p = pos[1] % N
        match pos[1] // N:
            case 0:
                pos = (0, 2*N + p)
                dir = (1, 0)
            case 1:
                pos = (3*N + p, N - 1)
                dir = (0, -1)
            case 2:
                pos = (N + p, 2*N - 1)
                dir = (0, -1)
    return pos, dir
        

def goPath() -> int:
    for i in range(maxWidth):
        if board[0][i] == ".":
            pos = (0,i)
            break

    dirpointer = 0

    for inst in instructions:
        match inst:
            case int(n):
                pos, dir = getNextPosAndDir(pos, directions[dirpointer], n)
                dirpointer = directions.index(dir)
            case "R":
                dirpointer = (dirpointer+1) % 4
            case "L":
                dirpointer = (dirpointer-1) % 4

    return 1000 * (pos[0] + 1) + 4 * (pos[1] + 1) + dirpointer

print(f"Part One: {goPath()}")
cube = True
print(f"Part Two: {goPath()}")                


