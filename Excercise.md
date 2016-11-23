Homework
=====

Given the type `f:(b->c) -> (a->b) -> (a->c)`

Implement as many functions with that signature as you can.

Now take the following template:


```csharp
class MyClass<TA,TB,TC>
{
    public TC F(Func<TB,TC> f, Func<TA,TB> g, x)
    {

    }
}
```

Leaving the signature of F as is, but doing anything else you want to the implementation of MyClass and F, how many different functions
can you write.

Which is easier to reason about? Why?
