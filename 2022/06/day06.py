with open("input.txt") as f:
    stream= f.read()

stack = []

for i, c in enumerate(stream):

    stack.append(c)

    if len(stack) == 4:
        dist = True
        for j, c1 in enumerate(stack):
            if c1 in stack[j+1:]:
                dist = False
        if dist:
            print(i+1)
            break
        stack.pop(0)