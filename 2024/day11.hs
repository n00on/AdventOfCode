
main = do
    stones <- map (read :: String -> Int) . words <$> readFile "input/11.txt"

    print $ part1 stones

part1 ss = length $ blinkN 25 ss

blinkN 0 ss = ss 
blinkN n ss = blinkN (n-1) (blink ss)


blink :: [Int] -> [Int]
blink = concatMap change

change :: Int -> [Int]
change 0 = [1]
change n = let s = show n
               l = length s 
               p = l `mod` 2 
               (first, second) = splitAt' (l `div` 2) s in
           if p == 0 then
                [read first, read second]
           else
                [n*2024] 
           
    where
        splitAt' = \n xs -> (take n xs, drop n xs)