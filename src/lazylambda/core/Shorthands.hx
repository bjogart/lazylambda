package lazylambda.core;

using tink.CoreApi;
using lazylambda.Core;

class Shorthands {
    public static inline function iterConcat<T>(iter: Iterable<T>, ...iters: Iterator<T>): Iterator<T> {
        return iter.iterator().concat(...iters);
    }

    public static inline function iterConcatIterables<T>(iter: Iterable<T>, ...iterables: Iterable<T>): Iterator<T> {
        return iter.iterator().concatIterables(...iterables);
    }

    public static inline function iterFilter<T>(iter: Iterable<T>, pred: T -> Bool): Iterator<T> {
        return iter.iterator().filter(pred);
    }

    public static inline function iterFlatMap<A, B>(iter: Iterable<A>, fun: A -> Iterator<B>): Iterator<B> {
        return iter.iterator().flatMap(fun);
    }

    public static inline function iterIndexed<T>(iter: Iterable<T>): KeyValueIterator<Int, T> {
        return iter.iterator().indexed();
    }

    public static inline function iterKeys<K, V>(iter: KeyValueIterable<K, V>): Iterator<K> {
        return iter.keyValueIterator().keys();
    }

    public static inline function iterValues<K, V>(iter: KeyValueIterable<K, V>): Iterator<V> {
        return iter.keyValueIterator().values();
    }

    public static inline function iterMap<A, B>(iter: Iterable<A>, fun: A -> B): Iterator<B> {
        return iter.iterator().map(fun);
    }

    public static inline function iterZip<A, B>(iter1: Iterable<A>, iter2: Iterator<B>): KeyValueIterator<A, B> {
        return iter1.iterator().zip(iter2);
    }

    public static inline function iterZipWithIterable<A, B>(iter: Iterable<A>, iterable: Iterable<B>): KeyValueIterator<A, B> {
        return iter.iterator().zipWithIterable(iterable);
    }

    public static inline function iterZipWithResult<T, R>(iter: Iterable<T>, fun: T -> R): KeyValueIterator<T, R> {
        return iter.iterator().zipWithResult(fun);
    }
}
