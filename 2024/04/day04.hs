
main = do
    input <- lines <$> readFile "input.txt"
    print $ part1 input

    --print $ diagonals input

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