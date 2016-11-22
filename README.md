Homework
============

Each chapter has two files. They are actually the same file. One is a symbolic link to the other. 

Files ending in *.md are the original files. These represent markdown files and can be viewed in GitHub and will appear properly formatted. Files ending in *.lhs are literate Haskell source files. With the program `markdown-unlit` they can be processed by `ghci`.

Make sure you've installed `markdown-unlit`

```sh
cabal update && cabal install markdown-unlit
```

After installation make sure that `markdown-unlit` is in your path by trying to run it.

Then you can run one of the files like this

```sh
ghci -pgmL markdown-unlit chapter7exercises.lhs
```