Chapter 8 Exercises
=================

1. In a similar manner to the function `add`, define a recursive multiplication function `mult :: Nat -> Nat -> Nat` for the recursive type of natural numbers: 

    Hint: make use of `add` in your definition.

    ~~~ {.haskell}
    data Nat = Zero | Succ Nat deriving Show

    nat2int :: Nat -> Int
    nat2int Zero = 0
    nat2int (Succ n) = 1 + (nat2int n)

    int2nat :: Int -> Nat
    int2nat 0 = Zero
    int2nat n = Succ $ int2nat $ n-1

    add :: Nat -> Nat -> Nat
    add Zero n = n
    add (Succ m) n = Succ $ add m n

    mult :: Nat -> Nat -> Nat
    mult Zero n = Zero
    mult (Succ m) n = add n (mult m n)
    ~~~

2. Although not included in *appendix B*, the standard prelude defines 

    ~~~
    data Ordering = LT | EQ | GT 
    ~~~

    together with a function 
    
    ~~~
    compare :: Ord a = > a -> a -> Ordering 
    ~~~

    that decides if one value in an ordered type is less than (`LT`), equal to (`EQ`), or greater than (`GT`) another value. Using this function, redefine the function `occurs :: Ord a => a -> Tree a -> Bool` for search trees. Why is this new definition more efficient than the original version?

    ~~~ {.haskell}
    data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving Show
    ~~~

    ~~~ {.haskell}
    occurs :: Ord a => a -> Tree a -> Bool
    occurs x (Leaf y) = x == y
    occurs x (Node l y r) = case compare x y of
                              EQ -> True
                              LT -> occurs x l
                              GT -> occurs x r
    ~~~

    This version only requires one comparison between `x` and `y` while the other version may sometimes need to compare them twice.

3. Consider the following type of binary trees: 

    ~~~ {.haskell}
    data Tree' a = Leaf' a | Node' (Tree' a) (Tree' a) deriving Show
    ~~~
    
    Let us say that such a tree is *balanced* if the number of leaves in the left and right subtree of every node differs by at most one, with leaves themselves being trivially balanced. Define a function `balanced :: Tree a -> Bool` that decides if a binary tree is balanced or not. 
    
    Hint: first define a function that returns the number of leaves in a tree.

    ~~~ {.haskell}
    leaves :: Tree' a -> Int
    leaves (Leaf' _) = 1
    leaves (Node' l r) = (leaves l) + (leaves r)

    balanced :: Tree' a -> Bool
    balanced (Leaf' _) = True
    balanced (Node' l r) = abs((leaves l) - (leaves r)) <= 1 && (balanced l) && (balanced r)
    ~~~

4. Define a function `balance :: [a] -> Tree' a` that converts a non-empty list into a balanced tree. 

    Hint: first define a function that splits a list into two halves whose length differs by at most one.

    ~~~ {.haskell}
    halve :: [a] -> ([a],[a])
    halve xs = (Prelude.take n xs, drop n xs)
               where n = length xs `div` 2

    balance :: [a] -> Tree' a
    balance (x:[]) = Leaf' x
    balance xs = let (ls,rs) = halve xs in
                   Node' (balance ls) (balance rs)
    ~~~


5. Given the type declaration 

    ~~~ {.haskell}
    data Expr = Val Int | Add Expr Expr 
    ~~~
    
    define a higher-order function `folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a` such that `folde f g` replaces each `Val` constructor in an expression by the function `f`, and each `Add` constructor by the function `g`.

    ~~~ {.haskell}
    folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a
    folde f _ (Val x) = f x
    folde f g (Add e1 e2) = g (folde f g e1) (folde f g e2)
    ~~~

6. Using `folde`, define a function `eval :: Expr -> Int` that evaluates an expression to an integer value, and a function `size :: Expr -> Int` that calculates the number of values in an expression.

    ~~~ {.haskell}
    eval :: Expr -> Int
    eval = folde id (+)

    size :: Expr -> Int
    size = folde (const 1) (+)
    ~~~


7. Complete the following instance declarations: 

    To avoid conflict with Prelude.Maybe, I defined Optional

    ~~~ {.haskell}
    data Optional a = None | Some a

    instance Eq a => Eq (Optional a) where 
      None == None = True
      (Some x) == (Some y) = x == y
      _ == _ = False
    ~~~
    
    To avoid conflic with Prelude.[], I defined List
    
    ~~~ {.haskell}
    data List a = Empty | Cons a (List a)

    instance Eq a => Eq (List a) where 
      Empty == Empty = True
      (Cons x xs) == (Cons y ys) = x == y && xs == ys
      _ == _ = False
    ~~~



Addendum
=======

Working ahead, I want to make `Tree'` Foldable and rewrite `balanced` and `leaves`

~~~ {.haskell}
instance Foldable Tree' where
  -- foldr :: (a -> b -> b) -> b -> t a -> b
  foldr acc s (Leaf' x) = acc x s 
  foldr acc s (Node' l r) = foldr acc (foldr acc s l) r
  -- foldMap :: Monoid m => (a -> m) -> t a -> m
  foldMap f (Leaf' x) = f x
  foldMap f (Node' l r) = (foldMap f l) `mappend` (foldMap f r)


