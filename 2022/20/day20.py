with open("input.txt") as f:
    nums = [int(n) for n in f.read().split("\n")]

def part1(numbers : list) -> int:
    nums = [(n, False) for n in numbers]
    i = 0
    while i < len(nums):
        n, b = nums[i]
        if b or n == 0:
            i += 1
            continue

        newpos = i + n
        newpos += newpos // len(nums)
        newpos %= len(nums)

        nums.pop(i)
        nums.insert(newpos, (n, True))

    index0 = nums.index((0, False))
    sum = 0
    for offset in [1000,2000,3000]:
        sum += nums[(index0+offset) % len(nums)][0]
    return sum


print(f"Part One: {part1(nums)}")