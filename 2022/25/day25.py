with open("input.txt") as f:
    snafu = f.read().split("\n")

def snafu2decimal(num : str) -> int:
    result = 0
    for sd in num:
        result *= 5
        result += normaldigit(sd)
    return result

def tosnafu(num : int) -> str:
    result = ""
    while num:
        d = num  % 5
        num //= 5
        if d > 2:
            num += 1
            d = (d + 2) % 5 - 2
        result = snafudigit(d) + result

    return result

digittable = ('=', '-', '0', '1', '2')
def normaldigit(sd : str) -> int:
    return digittable.index(sd) - 2
def snafudigit(d : int) -> str:
    return digittable[d + 2]


snafusum = sum([snafu2decimal(n) for n in snafu])
print(f"Part One: {tosnafu(snafusum)}")