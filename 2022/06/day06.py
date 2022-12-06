with open("input.txt") as f:
    stream = f.read()

def findMarker(length):
    stack = []
    for i, c in enumerate(stream):
        stack.append(c)

        if len(stack) == length:
            if len(set(stack)) == length:
                return(i+1)
                
            stack.pop(0)

print(f"Part One: {findMarker(4)}")
print(f"Part One: {findMarker(14)}")