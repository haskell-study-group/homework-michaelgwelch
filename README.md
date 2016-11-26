Homework
============

Each chapter exercise can be loaded into `ghci` by running

```
./load chapX.lhs
```



Each chapter has two files. They are actually the same file. One is a symbolic link to the other. 

Files ending in `.md` are the original files. These are markdown files and can be viewed in GitHub and will appear properly formatted. Files ending in `.lhs` are literate Haskell source files. With the program `markdown-unlit` they can be processed by `ghci`.

Make sure you've installed `markdown-unlit`

```sh
cabal update && cabal install markdown-unlit
```

After installation make sure that `markdown-unlit` is in your path by trying to run it.

Then you can run one of the files like this

```sh
ghci -pgmL markdown-unlit chapter7exercises.lhs
```

or

```sh
./load chapter7exercises.lhs
```

The `.lhs` files in this directory are not true literate Haskell. In literate Haskell code is designated using *bird tracks* like the following

```
> let x = 5
```

or by using code blocks like the following:

```
\begin{code}
let x = 5
\end{code}
```

However, these code blocks wouldn't be supported by Markdown. In the `.lhs` file we use a type of code block supported by Markdown. The `markdown-unlit` program then does the job of converting the approximate literate haskell into source code that ghci can actually process. 

Literate Haskell
---------------
You can learn more about [Literate Haskell](https://wiki.haskell.org/Literate_programming) at the link. 

You can learn more about `markdown-unlit` [here](https://github.com/sol/markdown-unlit)