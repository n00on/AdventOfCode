
main = do
    input <- readFile "input.txt"
    let reports = parse input
    print $ part1 reports

parse :: String -> [[Int]]
parse s = map (map read . words) (lines s)

part1 :: [[Int]] -> Int
part1 reports = length $ filter id $ map testReport reports
    where
        testReport :: [Int] -> Bool
        testReport xs = let ds@(d:_) = dlist xs in
                        all (\d1 -> signum d == signum d1 && abs d1 >= 1 && abs d1 <= 3) ds

        dlist :: [Int] -> [Int]
        dlist (x1:x2:xs) = (x1-x2) : dlist (x2:xs)
        dlist _          = []