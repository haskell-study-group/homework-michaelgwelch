Homework
=====

Given the type `f:(a->b) -> a -> b`

Implement as many functions with that signature as you can. How many of them are functionally equivalent. How many of them different (without just erroring out).

Now take the following template:


```csharp
class MyClass<TIn, TOut>
{
    public TOut F(TIn in)
    {

    }
}
```

Leaving the signature of F as is, but doing anything else you want to the implementation of MyClass and F, how many different functions
can you write. How many of them do completely different things (besides error out). How many different functions are possible?

Which type signature is easier to reason about (Haskell or C#)
Which is easier to reason about? Why?
