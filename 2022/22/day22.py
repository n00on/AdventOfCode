with open("input.txt") as f:
    input = f.read().split("\n\n")

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

def getNextPos(pos : (int), dir : (int), n : int) -> (int):
    for i in range(n):
        nextpos = ((pos[0] + dir[0]) % maxHeight, (pos[1] + dir[1]) % maxWidth)
        next = board[nextpos[0]][nextpos[1]]
        while next == ' ':
            nextpos = ((nextpos[0] + dir[0]) % maxHeight, (nextpos[1] + dir[1]) % maxWidth)
            next = board[nextpos[0]][nextpos[1]]
        
        if next == '.':
            pos = nextpos
        elif next == '#':
            return pos
    return pos

def goPath() -> int:
    for i in range(maxWidth):
        if board[0][i] == ".":
            pos = (0,i)
            break

    dirpointer = 0

    for inst in instructions:
        match inst:
            case int(n):
                pos = getNextPos(pos, directions[dirpointer], n)
            case "R":
                dirpointer = (dirpointer+1) % 4
            case "L":
                dirpointer = (dirpointer-1) % 4

    return 1000 * (pos[0] + 1) + 4 * (pos[1] + 1) + dirpointer

def getNextPosAndDir(pos : (int), dir : (int), n : int) -> (int):
    for i in range(n):
        nextpos = ((pos[0] + dir[0]) % maxHeight, (pos[1] + dir[1]) % maxWidth)
        next = board[nextpos[0]][nextpos[1]]
        while next == ' ':
            nextpos = ((nextpos[0] + dir[0]) % maxHeight, (nextpos[1] + dir[1]) % maxWidth)
            next = board[nextpos[0]][nextpos[1]]
        
        if next == '.':
            pos = nextpos
        elif next == '#':
            return pos
    return pos

print(f"Part One: {goPath()}")
                


