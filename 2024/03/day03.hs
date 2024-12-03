import Text.Parsec (parse)
import Text.Read (readMaybe)

main = do
    input <- readFile "input.txt"
    print $ part1 input

part1 :: String -> Int
part1 ('m':'u':'l':'(': rest) = case parseRest rest of
                                    Just (n, unparsed) -> n + part1 unparsed
                                    Nothing            -> part1 rest
part1 (_:rest) = part1 rest
part1 [] = 0


parseRest :: String -> Maybe (Int, String)
parseRest s = case parseInt 3 s of
                    Just (x1,',':s1) -> case parseInt 3 s1 of
                        Just (x2,')':s2) ->  Just (x1*x2, s2)
                        _ -> Nothing
                    _ -> Nothing


parseInt :: Int -> String -> Maybe (Int, String)
parseInt 0 _ = Nothing
parseInt n s = case readMaybe (take n s) :: Maybe Int of
                     Nothing -> parseInt (n-1) s
                     Just x -> Just (x, drop n s)