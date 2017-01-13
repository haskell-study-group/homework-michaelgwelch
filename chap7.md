Chapter 7 Excercises
===================

~~~ {.haskell}
import Data.Char
~~~

1. Show how the list comprehension `[f x | x <- xs, p x]` can be re-expressed using the higher-order functions `map` and `filter`.

    ~~~ {.haskell}
    map f (filter p xs)
    ~~~
2. Without looking at the definitions from the standard prelude, define the following higher-order library functions on lists.v

    a. Decide if all elements of a list satisfy a predicate:

    ~~~ {.haskell}
    all' p = foldr (\h b -> b && p h) True
    all :: (a -> Bool) -> [a] -> Bool
    all p = foldr (flip (&&) . p) True
    ~~~
    b. Decide if any element of a list satisfies a predicate:

    ~~~ {.haskell}
    any :: (a -> Bool) -> [a] -> Bool
    any p = foldr (flip (||) . p) False
    ~~~
    c. Select elements from a list while they satisfy a predicate:

    ~~~ {.haskell}
    takeWhile :: (a -> Bool) -> [a] -> [a]
    takeWhile p [] = []
    takeWhile p (x:xs) | p x = x : Main.takeWhile p xs
                       | otherwise = []
    ~~~
    d. Remove element from a list while they satisfy a predicate:

    ~~~ {.haskell}
    dropWhile :: (a -> Bool) -> [a] -> [a]
    dropWhile p [] = []
    dropWhile p (x:xs) | p x = Main.dropWhile p xs
                       | otherwise = x:xs
    ~~~

3. Redefine the functions `map f` and `filter p` using foldr.

    ~~~ {.haskell}
    map' f = foldr (\h ys -> f h : ys) []
    filter' p = foldr (\h ys -> if p h then h : ys else ys) []
    ~~~

4. Using `foldl`, define a function `dec2int :: [Int] -> Int` that converts a decimal number into an integer. For exmaple:

    ~~~ 
    > dec2int [2,3,4,5]
    2345
    ~~~

    ~~~ {.haskell}
    dec2int :: [Int] -> Int
    dec2int = foldl (\s h -> s*10 + h) 0
    ~~~

5. Without looking at the definitions from the standard prelude, define the higher-order library function `curry` that converts a function on pairs into a curried function, and conversely `uncurry` that converts a curried function into a function on pairs.

    ~~~ {.haskell}
    curry :: ((a,b) -> c) -> a -> b -> c
    curry f x y = f (x,y)

    uncurry :: (a -> b -> c) -> (a,b) -> c
    uncurry f (x,y) = f x y
    ~~~

6. A higher-order function `unfold` that encapsulates a simple pattern of recursion for producing a list can be defined as follows:

    ~~~ {.haskell}
    unfold p h t x | p x       = []
                   | otherwise = h x : unfold p h t (t x)
    ~~~

    That is, the function `unfold p h t` produces the empty list if the predicate `p` is true of the argument value, and otherwise produces a non-empty list by applying the function `h` to this value to give the head, and the function `t` to generate another argument that is recursively processed in the same way to produce the tail of the list. For example, the function `int2bin` can be rewritten more compactly using `unfold` as follows:

    ~~~ {.haskell}
    int2bin = Main.unfold (==0) (`mod` 2) (`div` 2)
    
    -- int2bin 5 = Main.unfold (==0) (`mod` 2) (`div` 2) 5
    --   = (5 `mod` 2) : unfold (==0) (`mod` 2) (`div` 2) (5 `div` 2)
    --   = 1 : unfold (==0) (`mod` 2) (`div` 2) 2
    --   = 1 : (2 `mod` 2) : unfold (==0) (`mod` 2) (`div` 2) (2 `div` 2)
    --   = 1 : 0 : unfold (==0) (`mod` 2) (`div` 2) 1
    --   = 1 : 0 : (1 `mod` 2) : unfold (==0) (`mod` 2) (`div` 2) (1 `div` 2)
    --   = 1 : 0 : 1 : unfold (==0) (`mod` 2) (`div` 2) 0
    --   = 1 : 0 : 1 : []
    --   = [1,0,1]
    ~~~

    Redefine the functions `chop8`, `map f`, and `iterate f` using `unfold`.

    ~~~ {.haskell}
    type Bit = Int
    chop8 :: [Bit] -> [[Bit]]
    chop8 = unfold null (take 8) (drop 8)

    map'' :: (a -> b) -> [a] -> [b]
    map'' f = unfold null (f . head) tail

    iterate :: (a -> a) -> a -> [a]
    iterate f = unfold (const False) id f
    ~~~

7. Modify the binary string transmitter example to detect simple transmission errors using the concept of parity bits. That is, each eight-bit binary number produced during encoding is extended with a parity bit, set to one if the number contains an odd number of ones, and to zero otherwise. In turn, each resulting nine-bit number consumed during decoding is checked to ensure that its parity bit is correct, with the parity bit being discarded if this is the case, and a parity error being reported otherwise. 

    Hint: the library function `error :: String -> a` displays the given string as an error message and terminates the program; the polymorphic result type ensures that `error` can be used in any context.

    ~~~ {.haskell}
    channel = id

    bin2int :: [Bit] -> Int
    bin2int = foldr (\h s -> h + 2*s) 0

    make8 :: [Bit] -> [Bit]
    make8 bits = take 8 (bits ++ repeat 0)

    encode :: String -> [Bit]
    encode = concat . map (make8 . int2bin . ord)

    decode :: [Bit] -> String
    decode = map (chr . bin2int) . chop8

    add_parity :: [Bit] -> [Bit]
    add_parity bits | odd (sum bits) = 1 : bits
                    | otherwise      = 0 : bits
    
    check_parity :: [Bit] -> [Bit]
    check_parity bits | even (sum bits) = tail bits
                      | otherwise       = error "parity error"

    trans = decode . channel . encode

    transmit :: String -> String
    transmit = decode . check_parity . channel . add_parity . encode

    ~~~

8. Test your new string transmitter program from the previous exercise using a faulty communication channel that forgets the first bit, which can be modelled using the tail function on lists of bits. 

    ~~~ {.haskell}
    channel' = tail

    transmit' :: String -> String
    transmit' = decode . check_parity . channel' . add_parity . encode
    ~~~

9. Define a function `altMap :: (a -> b) -> (a -> b) -> [a] -> [b]` that alternately applies its two argument functions to successive elements in a list, in turn about order. For example:

    ~~~
    > altMap (+10) (+100) [0,1,2,3,4]
    [10,101,12,103,14]
    ~~~

    ~~~ {.haskell}
    altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
    altMap _ _ [] = []
    altMap f g (x:xs) = f x : altMap g f xs
    ~~~

10. Using `altMap`, define a function `luhn :: [Int] -> Bool` that implements *Luhn algorithm* from the exercises in chapter 4 for bank card numbers of any length. Test your new function using your own bank card.

    ~~~ {.haskell}
    luhnDouble n | n < 5 = n * 2
                 | otherwise = (n * 2) - 9

    luhn :: [Int] -> Bool
    luhn digits = sum (altMap id luhnDouble (reverse digits)) `mod` 10 == 0

    luhn' = (0 ==) . (`mod` 10) . sum . altMap id luhnDouble . reverse
    ~~~


Extra Credit: Given the following definition for `Coin`:

~~~ {.haskell}
data Coin = Quarter | Dime | Nickel | Penny deriving Show
valueOf :: Coin -> Int
valueOf Quarter = 25
valueOf Dime    = 10
valueOf Nickel  =  5
valueOf Penny   =  1
~~~

Use `unfold` to write `makeChange :: Int -> [Coin]` that implements the
algorithm for making change that results in the least number of coins. The
input is the number of cents to make change for. The output is a list of coins.
The only coins to use are quarters, dimes, nickels and pennies.

For example: 

~~~
-- Change for 73 cents should be 2 quarters, 2 dimes and 3 pennies
> makeChange 73
[Quarter, Quarter, Dime, Dime, Penny, Penny, Penny]
~~~

Answer:

~~~ {.haskell}
makeChange :: Int -> [Coin]
makeChange n | n >= 0 = unfold (==0) nextCoin remainingCents n
               where nextCoin x | x >= 25 = Quarter
                                | x >= 10 = Dime
                                | x >=  5 = Nickel
                                | otherwise = Penny
                     remainingCents x = x - (valueOf (nextCoin x))
~~~
