with open("input.txt") as f:
    packets = [eval(p) for p in f.read().split("\n") if p != '']

def compare(left, right) -> int:
    match left, right:
        case int(left), int(right):
            return left - right

        case int(left), list(right):
            return compare([left], right)

        case list(left), int(right):
            return compare(left, [right])

        case list(left), list(right):
            for j in range(min(len(left), len(right))):
                c = compare(left[j], right[j])
                if c != 0:
                    return c
            return len(left) - len(right)

sum = 0
for i in range(0, len(packets), 2):
    if compare(packets[i], packets[i+1]) <= 0:
        sum += (i//2) + 1

print(f"Part One: {sum}")

# Short mergesort implementation to not use libraries lol
def merge_sort(input : list) -> list:
    if len(input) <= 1:
        return input
    mid = len(input)//2
    l = merge_sort(input[:mid])
    r = merge_sort(input[mid:])
    return merge(l, r)

def merge(l : list, r : list) -> list:
    result = []
    while len(l) > 0 and len(r) > 0:
        if compare(l[0], r[0]) <= 0:
            result.append(l.pop(0))
        else:
            result.append(r.pop(0))
    result += l
    result += r
    return result

divider = [[[2]], [[6]]]
s = merge_sort(packets + divider)
decoder_key = (s.index(divider[0]) + 1) * (s.index(divider[1]) + 1)
print(f"Part Two: {decoder_key}")