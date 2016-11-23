Homework
=====

Given the type `f:(a->b) -> a -> b`

Implement as many functions with that signature as you can. How many of them are functionally equivalent. How many of them different (without just erroring out).

Now take the following template:


```csharp
class MyClass<TIn, TOut>
{
    public TOut F(Func<TIn,TOut> g, TIn x)
    {

    }
}
```

Leaving the signature of F as is, and the type parameters on MyClass as they are, but doing anything else you want to the implementation of MyClass and F, how many different functions
can you write. How many of them do completely different things (besides error out). How many different functions are possible?

Which type signature is easier to reason about (Haskell or C#)
Which is easier to reason about? Why?
