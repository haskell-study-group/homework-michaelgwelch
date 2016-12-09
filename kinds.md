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


-- Curried Kinds (tuples)
Prelude> :kind (,)
(,) :: * -> * -> *
Prelude> :kind (,,)
(,,) :: * -> * -> * -> *
```

So what? C# has `kinds` as well doesn't it? For example, `List<T>` is a *higher-order type* that
takes one type and returns another, right? This is true but .Net has limited ability to allow you to write methods that handle any *kind* that has the same *interface*. Let me give you an example. The following method

```csharp
public static IEnumerable<TResult> Select<TSource, TResult>(
	this IEnumerable<TSource> source,
	Func<TSource, TResult> selector
)
```

is functionally equivalent to the `map` function from Haskell. Now let's define the following method as well:

```csharp
public static class NullableEx
{
    public static Nullable<TResult> Select<TSource, TResult>(this Nullable<TSource> source, Func<TSource, TResult> map)
        where TResult:struct
        where TSource:struct
    {
        return source.HasValue ? map(source.Value) : new Nullable<TResult>();
    }
}
```

This allows us to use a LINQ expression on nullables.

```csharp
int? x = 7;
int? y = from v in x
         select v * 2;
// Prints 14
Console.WriteLine(y);
```

However, what if I want to write a method that works with any type that has a `Select` method with the same *signature* shape? (Notice the signatures are very similiar. The only difference is one is using `List` and the other is using `Nullable`) We could of course use Reflection to do this, but there is no type safe way to do it.

This is where (hmmm, really kinds has nothing to do with polymorphism, just that polymorphism works on kinds as well as simple types. Think about this)

In Haskell we have a more general version of `map` called `fmap`

```haskell
fmap :: Functor f => (a -> b) -> f a -> f b
```

What does the `Functor f =>` part of that type signature mean? It means that if `f` is a `Functor` then the function `fmap` can be used with the type `f`.

The C# LINQ syntax is a bit like this. The definition for how the simple `select` statement in LINQ works is that **if** you define a method in the fashion I did for `Nullable` then you can use `select` on it.

In Haskell I can write my own functions that state they rely on this:

```haskell
timesTwo :: Functor f => f Int -> f Int
timesTwo n = fmap (*2) n
```

One function, it works for all Functors.

```
> timesTwo [1,2,3,4]
[2,4,6,8]
> timesTwo (Just 3)
Just 6
```

In C# I would need to write this function for every types I wanted it for: lists, nullables, etc. There is no way to write an interface or abstract class that List or Nullable could implement or subclass to allow this to work. Try it!

You might start by doing this:

```csharp
public interface IFunctor<TSource>
{
    // Applies selector to this instance of Functor<TSource> and returns
    // a new Functor of TResult. But what should I type where XXXXXX is?
    XXXXXX<TResult> Select<TResult>(Func<TSource,TResult> selector);
}
```

Sometimes we want XXXXX to be `List` and other times `Nullable`. C# has no way to express this. Let's review how this works in Haskell.

First I define the "interface" or in Haskell the type class:

``` Haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```

Notice the syntax allows me to declare a variable `f` for the type that implements the interface. This allows me to use it in the signature of methods on that "interface". 

I can attempt to declare any type of kind `* -> *` as a `Functor`. I know that `f` must be of kind `* -> *` because of the type signagure. Where you see `f a` it means that we are passing a type `a` to `f`. So I can make a list or a Maybe a functor. But there is no way to make an `Int` a functor. `Int` is the wrong kind.

```
instance Functor Maybe where
  -- fmap :: Functor f => (a -> b) -> f a -> f b
  fmap _ Nothing = Nothing
  fmap f (Just x) = Just $ f x
```

This is a higher level of abstraction that isn't really doable in most languages. 