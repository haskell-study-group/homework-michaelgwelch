Chapter 5 Exercise
==============

1. Using a list comprehension, give an expression that calculates the sum 1<sup>2</sup> + 2<sup>2</sup> + ... 100<sup>2</sup> of the first one hundred integer squares.

~~~ {.haskell}
summed = sum [ x^2 | x <- [1..100]]
~~~

2. Suppose that a *coordinate grid* of size $m × n$ is given by the list of all pairs (x, y) of integers such that Using a list comprehension, define a function grid :: Int -> Int -> [( Int, Int)] that returns a coordinate grid of a given size. For example: > grid 1 2 [( 0,0),( 0,1),( 0,2),( 1,0),( 1,1),( 1,2)]
