We are very familiar with types. What most developers are not familiar with are *kinds*.

*Kinds* are like "higher-order types". 

In Haskell there are two kinds:

* `*` means just a regular type. Like `Int` or `[Int]` or 
* `* -> *` means a kind that takes one type and produces another type, like `[]` or `Maybe`



Examples
-------
```shell
-- Simple Kinds
Prelude> :kind [Int]
[Int] :: *
Prelude> :kind (Maybe Int)
(Maybe Int) :: *
Prelude> :kind Int
Int :: *

-- Types vs Kinds
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
```
