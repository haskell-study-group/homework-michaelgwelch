

~~~ {.haskell}
f :: (a -> b) -> a -> b
f = id
~~~

~~~ {.haskell}
f' :: (a -> b) -> a -> b
f' g x = g x
~~~

In this case `f ≡ g`. They are functionally equivalent. How can the first solution work? How are they alike? How do they differe conceptually? I think of the first as taking a function and just returning that function. I think of the second as taking a function and an argument and passing the argument to the function.

Other than error scenarios, they will all be equivalent. 
Regarding the C# example.

~~~ {.csharp}
class MyClass<TIn, TOut>
{
    public TOut F(Func<TIn,TOut> g, TIn x)
    {
        return g(x);
    }
}
~~~

But there are an infinite different number of solutions. 

1. Use I/O in the constructor, or the function. That alone allows for an infinite amount of differences. 

2. Throw exceptions

3. `return default(TOut)`

4. Define a whole host of fields of type Func<?,?> and use reflection to find one that matches TIn and TOut. Use that one and call it with `x`.

5. Run an entire program (game, database program, etc.)



Question: Why is it not possible to do IO in `f` like you can in `F`. Why can't you find another function of type `a -> b` and use that like in C#?