with open("input.txt") as f:
    input = f.read().split("\n")

ops = dict()

for l in input:
    sp = l.split(" ")
    ops[sp[0][:4]] = sp[1:]

def getNum(monkey : str) -> int:
    op = ops[monkey]
    if len(op) == 1:
        return int(op[0])
    left = getNum(op[0])
    right = getNum(op[2])
    match op[1]:
        case "-":
            return left - right
        case "+":
            return left + right
        case "*":
            return left * right
        case "/":
            return left // right

print(getNum("root"))