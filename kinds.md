We are very familiar with types. What most developers are not familiar with are *kinds*.

*Kinds* are like "higher-order types". 

In Haskell there are two kinds:

* `*` means just a regular type. Like `Int` or `[Int]` or 



Examples
-------
Prelude> :type []
[] :: [t]
Prelude> :kind []
[] :: * -> *
Prelude> :type Just 3
Just 3 :: Num a => Maybe a
Prelude> :type Just
Just :: a -> Maybe a
Prelude> :kind Just

<interactive>:1:1: error:
    Not in scope: type constructor or class ‘Just’
    A data constructor of that name is in scope; did you mean DataKinds?
Prelude> :kind Maybe
Maybe :: * -> *
