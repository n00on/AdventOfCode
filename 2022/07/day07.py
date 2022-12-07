with open("input.txt") as f:
    terminal = f.read().split("\n")

class Dir:
    def __init__(self, name: str, parent,  size=0):
        self.parent = parent # alternative name dotdot?
        self.subdirs = []
        self.name = name
        self.size = size

terminal.pop(0)
root = Dir("/", None)

part1 = 0

cwd = root
for line in terminal:
    match line.split():
        case ["$", "cd", ".."]:
            if cwd.size <= 100000:
                part1 += cwd.size
            cwd.parent.size += cwd.size
            cwd = cwd.parent
        case ["$", "cd", target]:
            cwd = Dir(target, cwd)
            cwd.parent.subdirs.append(cwd)
        case ["$", "ls"]:
            pass
        case ["dir", dirname]:
            pass
        case [filesize, filename]:
            cwd.size += int(filesize)

while cwd != root:
    cwd.parent.size += cwd.size
    cwd = cwd.parent


print(f"Part One: {part1}")

def findSmallestDir(dir: Dir, minSize: int):
    if (dir.size >= minSize):
        return min([findSmallestDir(d, minSize) for d in dir.subdirs] + [dir.size])
    else: 
        return totalspace

totalspace = 70000000
requiredspace = 30000000

print(f"Part Two: {findSmallestDir(root, requiredspace - (totalspace - root.size))}")