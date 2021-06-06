package lazylambda.core;

using tink.CoreApi;
using fount.Core;
using lazylambda.Core;

class Sequentials {
    public static inline function concat<T>(iter: Iterator<T>, ...iters: Iterator<T>): Iterator<T> {
        return new ConcatIterator(iters.prepend(iter).iterator());
    }

    public static inline function concatWithIterables<T>(iter: Iterator<T>, ...iterables: Iterable<T>): Iterator<T> {
        return iter.concat(iterables.iterator().flatMap(iterable -> iterable.iterator()));
    }

    public static inline function filter<T>(iter: Iterator<T>, pred: T -> Bool): Iterator<T> {
        return new FilterIterator(iter, pred);
    }

    public static inline function flatMap<A, B>(iter: Iterator<A>, fun: A -> Iterator<B>): Iterator<B> {
        return new ConcatIterator(iter.map(fun));
    }

    public static inline function indexed<T>(iter: Iterator<T>): KeyValueIterator<Int, T> {
        return new IndexedIterator(iter);
    }

    public static inline function keys<K, V>(iter: KeyValueIterator<K, V>): Iterator<K> {
        return iter.map(kv -> kv.key);
    }

    public static inline function values<K, V>(iter: KeyValueIterator<K, V>): Iterator<V> {
        return iter.map(kv -> kv.value);
    }

    public static inline function map<A, B>(iter: Iterator<A>, fun: A -> B): Iterator<B> {
        return new MapIterator(iter, fun);
    }

    public static function rangeTo(start: Int, end: Int, ?step: Int): Outcome<Iterator<Int>, RangeIterError> {
        final dir = (end - start).sign();
        final step = step == null ? dir : step;
        if (dir != step.sign()) return Failure(MisalignedStep(start, end, step));
        if (dir == 0) return Success(new EmptyIterator());
        return Success(new RangeIterator(start, end, dir, step));
    }

    public static inline function zip<A, B>(iter1: Iterator<A>, iter2: Iterator<B>): KeyValueIterator<A, B> {
        return new ZipIterator(iter1, iter2);
    }

    public static inline function zipWithIterable<A, B>(iter: Iterator<A>, iterable: Iterable<B>): KeyValueIterator<A, B> {
        return new ZipIterator(iter, iterable.iterator());
    }

    public static inline function zipWithResult<T, R>(iter: Iterator<T>, fun: T -> R): KeyValueIterator<T, R> {
        return iter.map(v -> {key: v, value: fun(v) });
    }
}
