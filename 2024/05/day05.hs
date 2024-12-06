import Data.List (sortBy)

main = do
    (por, updates) <- span (/="") . lines <$> readFile "input.txt"
    print $ part1 (readPOR por) (readUpdates $ tail updates)
    print $ part2 (readPOR por) (readUpdates $ tail updates)

readPOR :: [String] -> [[Int]]
readPOR ps = let ps' = map readPORLine ps in
             [ [fst por | por <- ps', snd por == n] | n <- [0..99]]
    where
        readPORLine por = let (a,b) = span (/= '|') por
                              a':: Int = read a
                              b':: Int = read $ tail b in
                          (a',b')

readUpdates :: [String] -> [[Int]]
readUpdates = map readUpdate
    where
        readUpdate :: String -> [Int]
        readUpdate []         = []
        readUpdate (',':cs)   = readUpdate cs
        readUpdate (c1:c2:cs) = read [c1, c2] : readUpdate cs

--part1 :: [[Int]] -> [[Int]] -> Int
part1 por updates = sum $ map (\u -> u !! ((length u - 1) `div` 2)) $ filter (checkUpdate por) updates

checkUpdate :: [[Int]] -> [Int] -> Bool
checkUpdate por []     = True
checkUpdate por (p:ps) = all (\p' -> p' `notElem` (por !! p)) ps && checkUpdate por ps


part2 por updates = sum $ map ((\u -> u !! ((length u - 1) `div` 2)) . sortUpdate por)
                              (filter (not . checkUpdate por) updates)

sortUpdate :: Foldable t => [t Int] -> [Int] -> [Int]
sortUpdate por = sortBy (\a b -> if a `elem` por !! b then LT else GT)