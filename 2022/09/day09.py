with open("input.txt") as f:
    motions = [[c for c in l.split(" ")] for l in f.read().split("\n")]

dirs = {'R' : (1,0), 'L' : (-1,0), 'U' : (0,1), 'D' : (0,-1)}

def tailVisits(n : int):
    x = [0 for i in range(n)]
    y = [0 for i in range(n)]
    visited = [(0,0)]

    for dir in motions:
        for i in range(int(dir[1])):
            x[0] += dirs[dir[0]][0]
            y[0] += dirs[dir[0]][1]

            for j in range(1, n):
                xdiff = x[j-1] - x[j]
                ydiff = y[j-1] - y[j]
                diagonal = abs(xdiff) + abs(ydiff) > 2

                if diagonal or abs(xdiff) > 1:
                    x[j] += xdiff // abs(xdiff)
                if diagonal or abs(ydiff) > 1:
                    y[j] += ydiff // abs(ydiff)
                    
            if (x[n - 1], y[n - 1]) not in visited:
                visited.append((x[n - 1],y[n - 1]))

    return len(visited)


print(f"Part One: {tailVisits(2)}")
print(f"Part Two: {tailVisits(10)}")