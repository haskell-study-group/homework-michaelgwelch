class MyFunctor f where
  mymap :: (a->b) -> f a -> f b

instance MyFunctor [] where
  mymap _ [] = []
  mymap f xs = [ f x | x <- xs ]

instance MyFunctor Maybe where
  mymap _ Nothing = Nothing
  mymap f (Just x) = Just $ f x
