with open("input.txt") as f:
    trees = [[int(c) for c in line] for line in f.read().split("\n")]

countvisible = 0
bestscore = 0

for y, line in enumerate(trees):
    for x, tree in enumerate(line):
        score = 1
        visible = False

        for xdir, ydir in [(1,0), (0,1), (-1,0), (0,-1)]:
            y1 = y + ydir
            x1 = x + xdir
            visibledir = True
            dist = 0

            while visibledir and x1 >= 0 and y1 >= 0 and x1 < len(line) and y1 < len(trees):
                dist += 1
                visibledir = trees[y1][x1] < tree
                y1 += ydir
                x1 += xdir
                
            visible = visible or visibledir
            score *= dist

        if visible:
            countvisible += 1

        if score > bestscore:
            bestscore = score

print(f"Part One: {countvisible}")

print(f"Part Two: {bestscore}")