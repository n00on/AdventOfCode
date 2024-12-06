import Text.Read (readMaybe)

main = do
    input <- readFile "input/03.txt"
    print $ part1 input
    print $ part2 True input

part1 :: String -> Int
part1 ('m':'u':'l':'(': rest) = case parseRest rest of
                                    Just (n, unparsed) -> n + part1 unparsed
                                    Nothing            -> part1 rest
part1 (_:rest) = part1 rest
part1 [] = 0

part2 :: Bool -> String -> Int
part2 b ('d':'o':'n':'\'':'t':'(':')': rest) = part2 False rest
part2 b ('d':'o':'(':')': rest) = part2 True rest
part2 False (_:rest) = part2 False rest
part2 b ('m':'u':'l':'(': rest) = case parseRest rest of
                                    Just (n, unparsed) -> n + part2 b unparsed
                                    Nothing            -> part2 b rest
part2 b (_:rest) = part2 b rest
part2 b [] = 0


parseRest :: String -> Maybe (Int, String)
parseRest s = do 
    (x1,',':s1) <- parseInt 3 s
    (x2,')':s2) <- parseInt 3 s1
    return (x1*x2, s2)


parseInt :: Int -> String -> Maybe (Int, String)
parseInt 0 _ = Nothing
parseInt n s = case readMaybe (take n s) :: Maybe Int of
                     Nothing -> parseInt (n-1) s
                     Just x -> Just (x, drop n s)