with open("input.txt") as f:
    input = f.read().split("\n")

topen = 0

valves = dict()
opened = dict()
#q = []
score = dict()

for line in input:
    name = line.split(" ")[1]
    rate = int(line.split("rate=")[1].split(";")[0])
    if line.find("valve ") != -1:   
        to = [line.split(" valve ")[1]]
    else:
        to = [v for v in line.split(" valves ")[1].split(", ") if v != name]
    valves[name] = (rate, to)
    opened[name] = False
    #q.append(name)
    score[name] = 0
    if rate > 0:
        topen += 1

def red(valves : dict):
    result = dict()
    for valve in valves:
        if valves[valve][0] <= 0 and valve != 'AA':
            continue
        connections = dict()
        for v in valves[valve][1]:
            integrate(connections, findNext(v, set([valve])))
        result[valve] = (valves[valve][0], connections)
    return result

def findNext(vname :str, q : set) -> dict:
    if valves[vname][0] > 0:
        #print(vname)
        return {vname : 0}
    connections = dict()
    for v in valves[vname][1]:
        if v not in q:
            q.add(v)
            integrate(connections, findNext(v, q)) #[(i+1, vn) for i, vn in findNext(vname)]
            q.remove(v)
    return connections

def integrate(connections : dict, newcons : dict):
    for vname in newcons:
        if vname not in connections or newcons[vname] + 1 < connections[vname]:
            connections[vname] = newcons[vname] + 1 
    
#print(valves)
valves = red(valves)
print(valves)

def findPressure(pos : list, minutes : list, q : set) -> int:
    print(len(valves))
    if (minutes[0] <= 1 and minutes[1] <= 1) or len(q) == len(valves):
        return 0

    turn = 0 if minutes[0] >= minutes[1] else 1
    vname = pos[turn]
    valve = valves[vname]
    candidates = getSub(pos, turn, minutes, q)
    if vname not in q:
        minutes[turn] -= 1
        q.add(vname)
        candidates += [(minutes[turn]) * valve[0] + i for i in getSub(pos, turn, minutes, q)]
        q.discard(vname)
    
    if len(candidates) == 0: return 0
    return max(candidates)

def getSub(pos, turn, minutes, q):
    result = []
    valve = valves[pos[turn]]
    for v in valve[1]:
        if v in q:
            continue
        pos1 = [p for p in pos]
        pos1[turn] = v
        mins1 = [m for m in minutes]
        mins1[turn] -= valve[1][v]
        result.append(findPressure(pos1, mins1, q))
    return result

print(findPressure(['AA', 'AA'], [26,26], set(['AA'])))