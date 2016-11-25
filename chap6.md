Chapter 6 Exercises
================

1. How does the recursive version of the factorial function behave if applies to a negative argument, such as `(-1)`? Modify the definition to prohibit negative arguments by adding a guard to the recursive case.

    The function terminates with an error if called with a negative argument. This is because it enters an "infinite loop" that causes a stack overflow. 

    ~~~ {.haskell}
    fac :: Int -> Int
    fac 0 = 1
    fac n | n > 0 = n * fac (n-1)
    ~~~

2. Define a recursive function `sumdown :: Int -> Int` that returns the sum of the non-negative integers from a given value down to zero. For exmaple, `sumdown 3` should return the result `3+2+1+0=6`.

    ~~~ {.haskell}
    sumdown :: Int -> Int
    sumdown 0 = 0
    sumdown n | n > 0 = n + sumdown (n-1)
    ~~~

3. Define the exponentiation operator `^` for non-negative integers using the same pattern of recursion as the multiplication operator `*`, and show how the expression `2 ^ 3` is evalutated using your definition. 

   ~~~ {.haskell}
   (^) :: Int -> Int -> Int
   m ^ 0 = 1
   m ^ n | n > 0 = m * (m Main.^ (n-1))
   ~~~

   ~~~
      2 ^ 3
    =   { applying ^ }
      2 * (2 ^ 2)
    =   { applying ^ }
      2 * (2 * (2 ^ 1))
    =   { applying ^ }
      2 * (2 * (2 * (2 ^ 0)))
    =   { applying ^ }
      2 * (2 * (2 * 1))
    =   { applying * }
      8
   ~~~

4. Define a recursive function `euclid :: Int -> Int -> Int` that implements Euclid’s algorithm for calculating the greatest common divisor of two non-negative integers: if the two numbers are equal, this number is the result; otherwise, the smaller number is subtracted from the larger, and the same process is then repeated. For example:

    ~~~
    > euclid 6 27
    3
    ~~~

    ~~~ {.haskell}
    euclid :: Int -> Int -> Int
    euclid m n | m == n    = m
               | m > n     = euclid n (m-n)
               | otherwise = euclid m (n-m)
    ~~~

5. Using the recursive definitions given in this chapter, show how `length [1,2,3]`, `drop 3 [1,2,3,4,5]`, and `init [1,2,3]` are evaluated.

    ~~~ 
       length [1,2,3]
     =   { applying length }
       1 + length [2,3]
     =   { applying length }
       1 + (1 + length [3])
     =   { applying length }
       1 + (1 + (1 + length []))
     =   { applying length }
       1 + (1 + (1 + 0))
     =   { applying + }
       3
    ~~~

    ~~~
       drop 3 [1,2,3,4,5]
     =   { applying drop }
       drop 2 [2,3,4,5]
     =   { applying drop }
       drop 1 [3,4,5]
     =   { applying drop }
       drop 0 [4,5]
     =   { applying drop }
       [4,5]
    ~~~

    ~~~
      init [1,2,3] 
    =  { applying init }
      1 : init [2,3]
    =  { applying init }
      1 : (2 : init [3])
    =  { applying init }
      1 : (2 : [])
    =  { applying : }
      [1,2]
    ~~~

6. Without looking at the definitions from the standard prelude, define the following library functions on lists using recursion.

    a. Decide if all logical values in a list are `True`: 

    ~~~ {.haskell}
    and :: [Bool] -> Bool
    and []     = True
    and (x:xs) = x && (Main.and xs)
    ~~~
    
    b. Concatenate a list of lists: 

    ~~~ {.haskell}
    concat :: [[a]] -> [a]
    concat [] = []
    concat (x:xs) = x ++ (Main.concat xs)
    ~~~
    
    c. Produce a list with `n` identical elements: 

    ~~~ {.haskell}
    replicate :: Int -> a -> [a]
    replicate 0 _ = []
    replicate n x | n > 0 = x : (Main.replicate (n-1) x)
    ~~~
    
    d. Select the `n`<sup>th</sup> element of a list: 
    
    ~~~ {.haskell}
    (!!) :: [a] -> Int -> a
    (x:_) !! 0 = x
    (_:xs) !! n = xs Main.!! (n-1)
    ~~~
    
    e. Decide if a value is an element of a list: 
    
    ~~~ {.haskell}
    elem :: Eq a => a -> [a] -> Bool
    elem _ [] = False
    elem y (x:xs) | y == x = True
                  | otherwise = Main.elem y xs
    ~~~
    
    Note: most of these functions are defined in the prelude using other library functions rather than using explicit recursion, and are generic functions rather than being specific to the type of lists.

7. Define a recursive function `merge :: Ord a => [a] -> [a] -> [a]` that merges two sorted lists to give a single sorted list. For example: 

    ~~~
    > merge [2,5,6] [1,3,4]
    [1,2,3,4,5,6] 
    ~~~

    Note: your definition should not use other functions on sorted lists such as `insert` or `isort`, but should be defined using explicit recursion.

    ~~~ {.haskell}
    merge :: Ord a => [a] -> [a] -> [a]
    merge xs [] = xs
    merge [] ys = ys
    merge (x:xs) (y:ys) | x == y = x : y : merge xs ys
                        | x < y = x : merge xs (y:ys)
                        | otherwise = y : merge (x:xs) ys
    ~~~

8. Using `merge`, define a function `msort :: Ord a => [a] -> [a]` that implements merge sort, in which the empty list and singleton lists are already sorted, and any other list is sorted by merging together the two lists that result from sorting the two halves of the list separately. 

    Hint: first define a function `halve :: [a] -> ([a],[a])` that splits a list into two halves whose lengths differ by at most one.

    ~~~ {.haskell}
    halve :: [a] -> ([a],[a])
    halve xs = (take n xs, drop n xs)
               where n = length xs `div` 2
    
    msort :: Ord a => [a] -> [a]
    msort [] = []
    msort (x:[]) = [x]
    msort xs = let (ys,zs) = halve xs
               in merge (msort ys) (msort zs)
    ~~~

9. Using the five-step process, construct the library functions that: 

    a. calculate the `sum` of a list of numbers; 

    1. Define the type:

    ~~~
    sum :: [Int] -> Int
    ~~~

    2. Enumerate the cases:

    ~~~
    sum [] = 
    sum (x:xs) = 
    ~~~

    3. Define the simple cases

    ~~~
    sum [] = 0
    ~~~

    4. Define the other cases

    ~~~
    sum (x:xs) = x + sum xs
    ~~~

    5. Generalize and simplify

    ~~~ {.haskell}
    sum :: Num a => [a] -> a
    sum = foldr (+) 0
    ~~~~

    And done.

    b. take a given number of elements from the start of a list; 

    c. select the last element of a non-empty list.

  