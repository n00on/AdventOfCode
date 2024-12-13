import GHC.Float.RealFracMethods (roundDoubleInt)

main = do
    ws <- words <$> readFile "input/13.txt"

    print $ allOpts 0 ws
    print $ allOpts 10000000000000 ws


allOpts :: Int -> [String] -> Int
allOpts c [] = 0
allOpts c (_:_:('X':'+':xac):('Y':'+':ya):
           _:_:('X':'+':xbc):('Y':'+':yb):
           _:('X':'=':xgc):('Y':'=':yg):ws)
    = findOpt (read (init xac), read ya)
              (read (init xbc), read yb) 
              (c + read (init xgc), c + read yg)
      + allOpts c ws

findOpt :: (Int, Int) -> (Int, Int) -> (Int, Int) -> Int
findOpt (xa, ya) (xb, yb) (x, y) = 
    let t :: Double = fromIntegral $ xa*yb-ya*xb
        a = fromIntegral (-xb*y+yb*x) / t
        b = fromIntegral (-x*ya+y*xa) / t 
        ai = roundDoubleInt a 
        bi = roundDoubleInt b in
    if abs (a - fromIntegral ai) > 0.01
       || abs (b - fromIntegral bi) > 0.01 then
     0
    else
     3*ai + bi