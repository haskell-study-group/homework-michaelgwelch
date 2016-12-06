Chapter 5 Exercise
==============


1. Using a list comprehension, give an expression that calculates the sum 1<sup>2</sup> + 2<sup>2</sup> + ... 100<sup>2</sup> of the first one hundred integer squares.

    ~~~ {.haskell}
    summed = sum [ x^2 | x <- [1..100]]
    ~~~

2. Suppose that a *coordinate grid* of size `m × n` is given by the list of all pairs `(x,y)` of integers such that `0 <= x <= m` and `0 <= y <= n`. Using a list comprehension, define a function `grid :: Int -> Int -> [(Int,Int)]` that returns a coordinate grid of a given size. For example: 

    ~~~
    > grid 1 2
    [(0,0),(0,1),(0,2),(1,0),(1,1),(1,2)]
    ~~~

    ~~~ {.haskell}
    grid :: Int -> Int -> [(Int,Int)]
    grid m n = [ (x,y) | x <- [0..m], y <- [0..n]]
    ~~~

3. Using a list comprehension and the function `grid` above, define a function `square :: Int -> [(Int,Int)]` that returns a coordinate square of *size n*, excluding the diagonal from (0, 0) to (*n*, *n*). For example: 

    ~~~
    > square 2
    [(0,1),(0,2),(1,0),(1,2),(2,0),(2,1)]
    ~~~

    ~~~ {.haskell}
    square :: Int -> [(Int,Int)]
    square n = [ (x,y) | (x,y) <- grid n n, x /= y]
    ~~~

4. In a similar way to the function `length`, show how the library function `replicate :: Int -> a -> [a]` that produces a list of identical elements can be defined using a list comprehension. For example: 

    ~~~
    > replicate 3 True 
    [True, True, True]
    ~~~

    ~~~ {.haskell}
    replicate :: Int -> a -> [a]
    replicate n x = [ x | _ <- [0..(n-1)]]
    ~~~

5. A triple (*x*, *y*, *z*) of positive integers is Pythagorean if it satisfies the equation *x*<sup>2</sup> + *y*<sup>2</sup> = *z*<sup>2</sup>. Using a list comprehension with three generators, define a function `pyths :: Int -> [(Int,Int,Int)]` that returns the list of all such triples whose components are at most a given limit. For example: 

   ~~~
   > pyths 10 
   [(3,4,5),(4,3,5),(6,8,10),(8,6,10)]
   ~~~

   ~~~ {.haskell}
   pyths :: Int -> [(Int,Int,Int)]
   pyths n = [ (x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]
   ~~~

6. A positive integer is *perfect* if it equals the sum of all of its factors, excluding the number itself. Using a list comprehension and the function `factors`, define a function `perfects :: Int -> [Int]` that returns the list of all perfect numbers up to a given limit. For example:

    ~~~
    > perfects 500 
    [6,28,496]
    ~~~

    ~~~ {.haskell}
    factors :: Int -> [Int]
    factors n = [ x | x <- [1..n], n `mod` x == 0]

    perfect :: Int -> Bool
    --perfect n = sum (init (factors n)) == n
    perfect = (==) =<< sum . init . factors

    --perfects :: Int -> [Int]
    --perfects n = [ x | fs <- init $ factors n, ]
    ~~~
