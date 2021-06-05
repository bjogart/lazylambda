# Like `using Lambda;` but lazy
```haxe
[[1, 2, 3], [4, 5, 6], [], [7, 8, 9]].iterator()
    .concat([[10, 11, 12]].iterator())
    .flatMap(i -> 48 + 2 * i)
    .filter(IntTools)
    .map(String.fromCharCode)
    .toStrBy(str -> str, "", "", ""); // proper gibberish
```

That's the gist of it. This used to be part of [Ingot](https://github.com/BJogart/ingot), but I split it up because it got too big and messy. Most of the functions in this library work on Iterators instead of Iterables, which should be enough to let you do crazy things like the above, using only a single loop and some nested conditional statements.
