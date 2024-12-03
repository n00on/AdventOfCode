
main = do
    reports <- parse <$> readFile "input.txt"
    print $ part1 reports
    print $ part2 reports

parse :: String -> [[Int]]
parse s = map (map read . words) (lines s)

part1 :: [[Int]] -> Int
part1 reports = length $ filter id $ map testReport reports


testReport :: [Int] -> Bool
testReport xs = let ds@(d:_) = dlist xs in
                        all (\d1 -> signum d == signum d1 
                                 && abs d1 >= 1 && abs d1 <= 3) 
                            ds

dlist :: [Int] -> [Int]
dlist (x1:x2:xs) = (x1-x2) : dlist (x2:xs)
dlist _          = []

part2 :: [[Int]] -> Int
part2 reports = length $ filter id $ map (any testReport . perms) reports
    where
        perms :: [Int] -> [[Int]]
        perms [] = []
        perms xs@(x:xs') = xs' : map (x:) (perms xs')