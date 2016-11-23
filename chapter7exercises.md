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

> dec2int [2,3,4,5]
> 2345
