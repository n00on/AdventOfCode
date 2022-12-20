with open("input.txt") as f:
    input = [int(i) for i in f.read().split("\n")]

def mix(nums : list[int], order : list[int]):
    for i, index in enumerate(order):
        n = nums[index]
        if n == 0:
            continue

        newpos = index + n
        newpos %= len(nums) - 1
        dir = 1 if newpos > index else -1
        
        r = range(newpos, index) if dir == -1 else range(index+1,newpos+1)
        for j in range(len(nums)):
            if order[j] in r:
                order[j] = order[j] - dir
        
        nums.pop(index)
        nums.insert(newpos, n)

        order[i] = newpos

def getCoordinates(rounds = 1, factor = 1):
    order = [i for i in range(len(input))]
    nums = [n*factor for n in input]
    for _ in range(rounds):
        mix(nums, order)

    index0 = nums.index(0)
    sum = 0
    for offset in [1000,2000,3000]:
        sum += nums[(index0+offset) % len(nums)]
    return sum 

print(f"Part One: {getCoordinates()}")
print(f"Part Two: {getCoordinates(10, 811589153)}")