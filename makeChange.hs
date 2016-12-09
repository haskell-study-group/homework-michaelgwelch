
data Coin = Penny | Nickel | Dime | Quarter deriving Show

valueOf :: Coin -> Int
valueOf Penny   = 1
valueOf Nickel  = 5
valueOf Dime    = 10
valueOf Quarter = 25

unfold :: (t -> Bool) -> (t -> t1) -> (t -> t) -> t -> [t1]
unfold p h t s | p s = []
               | otherwise = h s : unfold p h t (t s)


largestCoinLE :: Int -> Coin
largestCoinLE n | n >= 25 = Quarter
                | n >= 10 = Dime
                | n >=  5 = Nickel
                | otherwise = Penny

makeChange :: Int -> [Coin]
makeChange n = unfold (==0) h t n
  where h x = largestCoinLE x
        t x = x - (valueOf $ largestCoinLE x)
