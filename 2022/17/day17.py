with open("input.txt") as f:
    jets = f.read()

stones = [[30],[8, 28, 8], [28,4,4], [16,16,16,16], [24,24]]

stack = []

def sim(rounds):
    global stack
    nextstone = 0
    jetpointer = 0
    while nextstone < rounds:
        stack += [0,0,0,0,0,0,0]
        stone = stones[nextstone % len(stones)].copy()
        stackpointer = len(stack) - 3

        falling = True
        while(falling):
            stackpointer -= 1

            operation = (lambda x : x*2) if jets[jetpointer] == '<' else (lambda x : x//2)  
            possible = True
            for i, row in enumerate(stone):
                res = operation(row)
                possible = possible and res < 128 and (jets[jetpointer] == '<' or 1 & row != 1)
                possible = possible and (res | stack[stackpointer + i] == res + stack[stackpointer + i])

            if possible:
                stone = [operation(row) for row in stone]

            jetpointer = (jetpointer + 1) % len(jets)

            falling = stackpointer != 0
            for i, row in enumerate(stone):
                falling = falling and (row | stack[stackpointer + i - 1] == row + stack[stackpointer + i - 1])

        for row in stone:
            stack[stackpointer] = stack[stackpointer] + row
            stackpointer += 1


        #stack = stack[:stackpointer]
        stack = [s for s in stack if s != 0]
        nextstone += 1

sim(2022)

#print(stack)
print(len(stack))