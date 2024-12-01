import Data.List (sort)

main = do 
    input <- readFile "input.txt"
    let (xs, ys) = unzip $ map toTuple $ lines input
    print $ part1 xs ys
    print $ part2 xs ys

part1 :: [Int] -> [Int] -> Int
part1 xs ys = let xs' = sort xs
                  ys' = sort ys
              in distance $ zip xs' ys' 

distance :: [(Int, Int)] -> Int
distance = foldr (\(x, y) z -> z + abs (x-y)) 0

part2 :: [Int] -> [Int] -> Int
part2 [] _ = 0
part2 (x:xs) ys = x * length (filter  (x ==) ys) + part2 xs ys


toTuple :: String -> (Int, Int)
toTuple cs = let [a,b] = words cs in (read a, read b)