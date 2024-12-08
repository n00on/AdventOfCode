import Data.Map (Map)
import qualified Data.Map as Map
import Data.List (nub)


main = do
    map <- lines <$> readFile "input/08.txt"
    print $ part1 map
    print $ part2 map

readMap :: [(Int, [(Int, Char)])] -> Map Char [(Int, Int)]
readMap []          = Map.empty
readMap ((y, r):rs) = Map.unionWith (++) (readRow y r) (readMap rs)
  where
    readRow :: Int -> [(Int, Char)] -> Map Char [(Int, Int)]
    readRow _ []            = Map.empty
    readRow y ((x, '.'):cs) = readRow y cs
    readRow y ((x, c):cs)   = Map.insertWith (++) c [(x,y)] (readRow y cs)

part1 amap = let mmap = readMap $ (zip [0::Int ..] . map (zip [0::Int ..])) amap
                 h = length amap
                 w = length (head amap) in
  length $ (filter (\(x,y) -> x >= 0 && y >= 0 && x < w && y < h) . nub . concatMap getAntinodes . Map.elems) mmap

getAntinodes :: [(Int, Int)] -> [(Int, Int)]
getAntinodes ps = concat [antinodes a1 a2 | a1 <- ps, a2 <- ps, a1 /= a2]
  where
    antinodes (x1, y1) (x2, y2) = let xd = x2-x1
                                      yd = y2-y1 in
                                  [(x1-xd, y1-yd), (x2+xd, y2+yd)]


part2 amap = let mmap = readMap $ (zip [0::Int ..] . map (zip [0::Int ..])) amap
                 h = length amap
                 w = length (head amap) in
  length $
    (filter (inBounds (w,h)) . nub . concatMap (getAllAntinodes (w,h)) . Map.elems) mmap

getAllAntinodes :: (Int, Int) -> [(Int, Int)] -> [(Int, Int)]
getAllAntinodes (w, h) ps = concat [antinodes a1 a2 | a1 <- ps, a2 <- ps, a1 /= a2]
  where
    antinodes (x1, y1) (x2, y2) = let xd = x2-x1
                                      yd = y2-y1 in
                                  (antinodesDir (x1,y1) (-xd,-yd) ++ antinodesDir (x2,y2) (xd,yd))

    antinodesDir (x,y) (xd,yd)
      | inBounds (w,h) (x,y) = (x,y) : antinodesDir (x+xd, y+yd) (xd,yd)
      | otherwise            = []

inBounds :: (Int, Int) -> (Int, Int) -> Bool
inBounds (w,h) (x,y) = x >= 0 && y >= 0 && x < w && y < h