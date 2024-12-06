
main = do
    input <- lines <$> readFile "input/04.txt"
    print $ part1 input

    print $ part2 input

part1 :: [String] -> Int
part1 input = sum $ map testString 
              (input ++ verticals input ++
               diagonals input ++ diagonals (map reverse input)) 

diagonals :: [String] -> [String] -- only diagonals from top left to bottom right
diagonals ss = let h = length ss
                   w = length $ head ss in
               [ [ (ss !! (x+y)) !! x | x <- [0..w-1], y + x < h ] | y <- [0..h-1]] ++
               [ [ (ss !! y) !! (x+y) | y <- [0..h-1], y + x < w ] | x <- [1..w-1]]

verticals :: [String] -> [String]
verticals ss = [ [ s !! n | s <- ss ] | n <- [0..length (head ss) - 1]]



testString :: String -> Int
testString [] = 0
testString ('X':'M':'A':'S':r) = 1 + testString ('S':r)
testString ('S':'A':'M':'X':r) = 1 + testString ('X':r)
testString (_:r) = testString r

part2 :: [String] -> Int
part2 []         = 0
part2 ss@(_:ss') = testX ss + part2 ss'

testX :: [String] -> Int
testX (r1@('M':_:'M':_) : r2@(_:'A':_) : r3@('S':_:'S':_) : r)
    = 1 + testX (tail r1 : tail r2 : tail r3 :r)
testX (r1@('M':_:'S':_) : r2@(_:'A':_):r3@('M':_:'S':_):r)
    = 1 + testX (tail r1 : tail r2 : tail r3 :r)
testX (r1@('S':_:'M':_):r2@(_:'A':_):r3@('S':_:'M':_):r)
    = 1 + testX (tail r1 : tail r2 : tail r3 :r)
testX (r1@('S':_:'S':_):r2@(_:'A':_):r3@('M':_:'M':_):r)
    = 1 + testX (tail r1 : tail r2 : tail r3 :r)
testX (r1@(_:_):r2@(_:_):r3@(_:_):r) = testX (tail r1 : tail r2 : tail r3 :r)
testX _ = 0