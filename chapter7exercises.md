Chapter 7 Excercises
===================

1. Show how the list comprehension `[f x | x <- xs, p x]` can be re-expressed using the higher-order functions `map` and `filter`.
~~~ {.haskell}
    f1 f p xs = map f (filter p xs)
~~~ 
2. Without looking at the definitions from the standard prelude, define the following higher-order library functions on lists.

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
c. Seect elements from a list while they satisfy a predicate:

~~~ {.haskell}
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile = undefined
~~~


