
main = do
    eqs <- map (readEQ . words) . lines <$> readFile "input/07.txt"
    print $ part1 eqs
    print $ part2 eqs

readEQ :: [String] -> (Int, [Int])
readEQ (r:os) = (read (init r), map read os)

part1 :: [(Int, [Int])] -> Int
part1 = sum . map fst . filter (checkEQ [(*), (+)])

checkEQ :: [Int -> Int -> Int] -> (Int, [Int]) -> Bool
checkEQ ops (r, o:os) = checkEQ' o os
    where
        checkEQ' :: Int -> [Int] -> Bool
        checkEQ' n []     = n == r
        checkEQ' n (o:os) = n <  r && any (\op -> checkEQ' (op n o) os) ops


part2 :: [(Int, [Int])] -> Int
part2 = sum . map fst . filter (checkEQ [(*), (+), concat])
    where
        concat :: Int -> Int -> Int
        concat x y =  x * (10 ^ (1 + (floor . logBase 10 . fromIntegral) y)) + y
        --concat x y = read $ show x ++ show y