with open("input.txt") as f:
        rounds = f.readlines()

def getScore(rounds, strategy):
    score = 0
    for r in rounds:
        enemyround = ord(r[0]) - ord('A')
        myround = strategy(enemyround, r[2])

        score += myround + 1 + 3 * ((myround - enemyround + 1) % 3)


    return score


print(getScore(rounds, lambda e, m: ord(m) - ord('X')))

print(getScore(rounds, lambda e, s: (e - 1 + ord(s) - ord('X')) % 3))