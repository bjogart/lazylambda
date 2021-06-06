# Like `using Lambda;` but lazy
```haxe
[[13, 256], [334, 0, 321]].iterConcatIterables([[], [30, 29]])
        .zipWithIterable([2, 0, 0, 5])
        .flatMap(it -> it.key.iterMap(i -> i - it.value))
        .filter(i -> i <= 30)
        .map(i -> i + 65)
        .toStrBy(String.fromCharCode, "Now that's ", "", " evaluation!");
```

That's the gist of it. This used to be part of [Ingot](https://github.com/BJogart/ingot), but I split it up because it got too big and messy. Most of the functions in this library work on Iterators instead of Iterables, which should be enough to let you do crazy things like the above, using only a single loop and some nested conditional statements.
