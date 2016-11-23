Chapter 7 Excercises
===================

1. Show how the list comprehension `[f x | x <- xs, p x]` can be re-expressed using the higher-order functions `map` and `filter`.

    ~~~ {.haskell}
    f1 f p xs = map f (filter p xs)
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