with open("input.txt") as f:
    terminal = f.read().split("\n")

class Tree:
    def __init__(self, name, parent, size=0):
        self.parent = parent
        self.children = []
        self.name = name
        self.size = size

root = Tree("/", None)
terminal.pop(0)

part1 = 0

cDir = root
for line in terminal:
    match line.split():
        case ["$", "cd", ".."]:
            if cDir.size <= 100000:
                part1 += cDir.size
            cDir.parent.size += cDir.size
            cDir = cDir.parent
        case ["$", "cd", target]:
            cDir = Tree(target, cDir)
            cDir.parent.children.append(cDir)
        case ["$", "ls"]:
            pass
        case ["dir", dirname]:
            pass
        case [filesize, filename]:
            cDir.size += int(filesize)

while cDir != root:
    cDir.parent.size += cDir.size
    cDir = cDir.parent


print(f"Part One: {part1}")

totalspace  = 70000000
neededspace = 30000000

def findSmallestDir(dir: Tree, size: int):
    if (dir.size > size):
        return min([findSmallestDir(node,size) for node in dir.children] + [dir.size])
    else: 
        return totalspace

print(f"Part Two: {findSmallestDir(root, neededspace - (totalspace - root.size))}")