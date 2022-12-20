with open("input.txt") as f:
    input = [int(l) for l in f.read().split("\n")]

def mix(nums : list[int], order : list[int]) -> None:
    for i, index in enumerate(order):
        n = nums[index]
        if n == 0:
            continue

        newpos = (index + n) % (len(nums) - 1)
        nums.pop(index)
        nums.insert(newpos, n)

        dir = 1 if newpos > index else -1
        r = (newpos, index) if dir == -1 else (index+1, newpos+1)
        for j in range(len(order)):
            if r[0] <= order[j] < r[1]: 
                order[j] = order[j] - dir
        order[i] = newpos

def getCoordinates(rounds = 1, factor = 1) -> int:
    order = list(range(len(input)))
    nums = [n*factor for n in input]
    for _ in range(rounds):
        mix(nums, order)

    index0 = nums.index(0)
    return sum([nums[(index0+offset) % len(nums)] 
                for offset in [1000,2000,3000]])

print(f"Part One: {getCoordinates()}")
print(f"Part Two: {getCoordinates(10, 811589153)}")